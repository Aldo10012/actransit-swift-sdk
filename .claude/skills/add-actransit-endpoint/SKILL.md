---
name: add-actransit-endpoint
description: End-to-end integration of a single AC Transit REST API endpoint into the ACTransitSwift SDK. Adds the endpoint case to the appropriate per-group endpoint enum, generates the Swift model struct, wires the service, and writes tests. Invoke with the endpoint path to add, e.g. "gtfs/all" or "routes/{routeId}/stops".
---

# Add AC Transit Endpoint

Adds full SDK support for one AC Transit REST API endpoint. The argument is the path **without** the leading slash (e.g. `gtfs/all`, `routes/{routeId}/stops`).

## Step 1 — Read the local reference file

Determine the resource group from the first path segment:

| First segment | Reference file |
|---|---|
| `gtfs` | `@../../ac-transit-api/references/gtfs.md` |
| `routes` | `@../../ac-transit-api/references/routes.md` |
| `trips` | `@../../ac-transit-api/references/trips.md` |
| `stops` | `@../../ac-transit-api/references/stops.md` |
| `vehicles` | `@../../ac-transit-api/references/vehicles.md` |
| `actrealtime` | `@../../ac-transit-api/references/act-realtime.md` |
| `gtfsrt` | `@../../ac-transit-api/references/gtfs-realtime.md` |

Read the matching reference file for context about the endpoint.

## Step 2 — Cross-reference the live API docs

**Find the Help URL** by fetching the Help index and locating the matching endpoint:

```
https://api.actransit.org/transit/Help
```

The Help URL format follows this pattern:
- Replace `/` with `-` in the path
- Remove `{` and `}` from path params (keep the param name)
- Append required/key query params with `_paramName`

Examples:
- `gtfs/all` → `https://api.actransit.org/transit/Help/Api/GET-gtfs-all`
- `routes/{booking}?sortType={sortType}` → `https://api.actransit.org/transit/Help/Api/GET-routes-booking_sortType`
- `trips/tripcancellationinfo/{tripNumber}` → `https://api.actransit.org/transit/Help/Api/GET-trips-tripcancellationinfo-tripNumber`

If the constructed URL returns an error, fetch the Help index to find the exact URL.

Fetch the Help page for this endpoint and extract:
1. The exact **response JSON sample**
2. The **resource model name** — look for the `?modelName=` link in the response description
3. All **path parameters**, their types, and full descriptions
4. All **query parameters** beyond `token` — names, types, required vs optional, typed enum values, and full descriptions
5. Whether the response is **binary** (ZIP / protobuf) rather than JSON

**Call the actual API to verify** — if an API token is available, call the live endpoint and confirm the response shape matches the docs. Use real response values for `.sample` data, not placeholder strings.

### Verify and update the reference file

Compare what the live docs say against the local reference file. If there are discrepancies (missing fields, wrong types, outdated response shape), update the reference file to match the live docs before proceeding.

## Step 3 — Classify the endpoint

Based on what you found, classify:

- **Binary response** (`/gtfs/current`, `/gtfs/next`, `/gtfs/{bookingId}`, `/gtfs/download`, any GTFS-RT endpoint): log a note that binary responses are not yet supported, and stop. Do not generate a struct or client method.
- **JSON response, no path params, no extra query params**: standard case.
- **JSON response, with path params**: parameterized case — note each param name and type.
- **JSON response, with extra query params** (beyond `token`): add them as function arguments.
- **Array response** (`[ModelName]`): the return type is `[ModelName]`.

## Step 4 — Derive Swift names

The SDK uses a service-namespaced architecture. Each resource group has its own endpoint enum and service struct. Method names are concise — the service already carries the resource group context, so don't repeat it in the method name.

| Artifact | Rule | Example |
|---|---|---|
| Endpoint case name | camelCase of path segments after the group prefix, params become labels | `all`, `booking(bookingId:)` |
| Service method name | camelCase of path segments after the group prefix, params become argument labels | `all()`, `booking(bookingId:)` |
| Endpoint enum name | PascalCase group name + `Endpoint` | `GTFSEndpoint`, `RoutesEndpoint` |
| Service struct name | PascalCase group name + `Service` | `GTFSService`, `RoutesService` |
| Model file name | resource model name from API docs | `GtfsScheduleInfo.swift` |
| Test file name | model name + `Tests` | `GtfsScheduleInfoTests.swift` |

For path parameters, name the associated value after the parameter (e.g. `case booking(bookingId: String)`).

## Step 5 — Generate the Swift model

Invoke the `swift-struct-generator` skill with:
- The **exact JSON sample** from the live API docs
- The **resource model name** as the required struct name
- The instruction that all types must be `public`, `Codable`, and `Sendable`
- Note any date fields (ISO 8601 with potential 7 fractional-second digits) so the generator handles them with a custom decoder using `ISO8601DateFormatter.ACTFormat` from the shared extension — never declare a new per-struct formatter

Above the struct declaration, add a `///` doc comment with the ResourceModel URL:

```swift
/// https://api.actransit.org/transit/Help/ResourceModel?modelName=GtfsInfo
public struct GtfsInfo: Codable, Sendable {
```

`.sample` values must use **real data from a live API call**, not placeholder strings like `"sample string 1"`.

For each property, fetch `https://api.actransit.org/transit/Help/ResourceModel?modelName={ModelName}` and add a `///` doc comment with the API's description above the property declaration. Only add a doc comment if the API docs provide a description for that property — omit it if they don't.

Write the generated file to:
```
Sources/ACTransitSwift/Models/{ModelName}.swift
```

## Step 6 — Update the endpoint enum

File: `Sources/ACTransitSwift/Endpoints/{Group}Endpoint.swift`

If the file doesn't exist yet (new resource group), create it following the same pattern as `GTFSEndpoint.swift` or `TripsEndpoint.swift`.

Add the new case and extend both switch statements:

Above each new case, add a `///` doc comment with the **actual API endpoint URL** (not the Help URL), followed by `/// - Parameters:` docstrings for each associated value:

**Standard (no path params):**
```swift
/// https://api.actransit.org/transit/gtfs/all
case all

// path switch:
case .all: "/gtfs/all"

// getRequest(token:) switch:
case .all:
    factory.build(httpMethod: .GET, baseUrlString: url, parameters: [apiTokenQueryParameter])
```

**Parameterized:**
```swift
/// https://api.actransit.org/transit/routes/{booking}?sortType={sortType}
/// - Parameters:
///   - booking: Unique id representing a specific schedule. Use `Current` or `nil` for the current schedule, `Next` for the next, or a specific BookingId.
///   - sortType: Indicates how the routes should be sorted. Default is natural sort.
case routes(booking: String? = nil, sortType: RouteSortType? = nil)

// path switch:
case let .routes(booking, _):
    if let booking { "/routes/\(booking)" } else { "/routes" }

// getRequest(token:) switch:
case let .routes(_, sortType):
    var params: [HTTPParameter] = [tokenParam]
    if let sortType { params.append(HTTPParameter(key: "sortType", value: sortType.rawValue)) }
    return factory.build(httpMethod: .GET, baseUrlString: url, parameters: params)
```

**Extra query params** (e.g. a `limit` param): add additional `HTTPParameter` values to the `parameters` array.

## Step 7 — Update the service

File: `Sources/ACTransitSwift/Services/{Group}Service.swift`

If the file doesn't exist yet (new resource group), create it following the same pattern as `GTFSService.swift` or `TripsService.swift`, and add a `public let {group}: {Group}Service` property to `ACTransitClient` in `Sources/ACTransitSwift/ACTransitClient.swift`.

Add a `public func` that calls through to the endpoint. Include a `///` summary line followed by `/// - Parameters:` docstrings for each argument, with descriptions copied from the API docs:

**Standard:**
```swift
/// All schedules: past, current, and future.
public func all() async throws -> [GtfsInfo] {
    try await performer.perform(request: GTFSEndpoint.all.getRequest(token: token), decodeTo: [GtfsInfo].self)
}
```

**Parameterized:**
```swift
/// Retrieves all AC Transit routes for a given booking period.
/// - Parameters:
///   - booking: Unique id representing a specific schedule. Use `Current` or `nil` for the current schedule, `Next` for the next, or a specific BookingId.
///   - sortType: Indicates how the routes should be sorted. Default is natural sort.
public func routes(booking: String? = nil, sortType: RouteSortType? = nil) async throws -> [RouteDivision] {
    try await performer.perform(
        request: RoutesEndpoint.routes(booking: booking, sortType: sortType).getRequest(token: token),
        decodeTo: [RouteDivision].self
    )
}
```

## Step 8 — Write model tests

File: `Tests/ACTransitSwiftTests/Models/{ModelName}Tests.swift`

Use the Swift Testing framework (`import Testing`, `@Suite`, `@Test`, `#expect`). Follow the same structure as `GtfsScheduleInfoTests.swift`.

The `@Suite` name must start with `"Test "` (e.g. `@Suite("Test GtfsInfo")`).

Cover:

1. **Decode happy path** — standard JSON with expected field values
2. **Decode edge cases** — 7-digit fractional seconds (if dates present), optional fields as `nil`, array empty case
3. **Decode failure** — malformed date string or missing required key throws `DecodingError`
4. **Encode** — encoded JSON uses the original PascalCase / snake_case keys (not Swift camelCase)
5. **Round-trip** — `encode → decode` preserves all field values
6. **Mock data** — `sample` data is self-consistent (e.g. end date > start date)
7. **`make()` factory** — overriding one argument leaves the others at their defaults

## Step 9 — Update the endpoint tests

File: `Tests/ACTransitSwiftTests/Endpoints/{Group}EndpointTests.swift`

If the file doesn't exist yet (new resource group), create it following the same pattern as `GTFSEndpointTests.swift` or `TripsEndpointTests.swift`.

Add a `@Test` for the new endpoint case:

```swift
@Test("test GTFSEndpoint.all")
func all() {
    let endpoint = GTFSEndpoint.all
    let request = endpoint.getRequest(token: Constants.mockToken)

    #expect(endpoint.path == "/gtfs/all")
    #expect(request.httpMethod == .GET)
    #expect(request.baseUrl == "https://api.actransit.org/transit/gtfs/all")
    #expect(request.parameters == [HTTPParameter(key: Constants.tokenKey, value: Constants.mockToken)])
}
```

For parameterized endpoints, pass a representative value and verify the path contains it:

```swift
@Test("test GTFSEndpoint.booking")
func booking() {
    let endpoint = GTFSEndpoint.booking(bookingId: "25FASU")
    let request = endpoint.getRequest(token: Constants.mockToken)

    #expect(endpoint.path == "/gtfs/25FASU")
    #expect(request.httpMethod == .GET)
    #expect(request.baseUrl == "https://api.actransit.org/transit/gtfs/25FASU")
    #expect(request.parameters == [HTTPParameter(key: Constants.tokenKey, value: Constants.mockToken)])
}
```

## Step 10 — Add service tests

File: `Tests/ACTransitSwiftTests/Services/{Group}ServiceTests.swift`

If the file doesn't exist yet (new resource group), create it following the same pattern as `GTFSServiceTests.swift` or `TripsServiceTests.swift`.

Append a new `@Test` inside the suite. The mock JSON must use the same PascalCase keys the API returns. Assert every field against the model's `.sample` static property.

**Standard (single object) response:**
```swift
@Test("test .active() success case")
func active() async throws {
    let jsonString = """
    {
        "UpdatedDate": "2025-05-01T12:00:00.0000000-07:00",
        "EarliestServiceDate": "2025-04-28T00:00:00.0000000-07:00",
        "LatestServiceDate": "2025-08-31T00:00:00.0000000-07:00"
    }
    """
    setup(mockJSON: jsonString.data(using: .utf8))

    let result = try await sut.active()

    #expect(result.updatedDate == GtfsScheduleInfo.sample.updatedDate)
    #expect(result.earliestServiceDate == GtfsScheduleInfo.sample.earliestServiceDate)
    #expect(result.latestServiceDate == GtfsScheduleInfo.sample.latestServiceDate)
}
```

**Array response** — wrap in `[…]`, assert `count == 1`, index into `result[0]`:
```swift
@Test("test .all() success case")
func all() async throws {
    let jsonString = """
    [
        {
            "BookingId": "25FASU",
            "UpdatedDate": "2025-05-01T12:00:00.0000000-07:00",
            "EarliestServiceDate": "2025-04-28T00:00:00.0000000-07:00",
            "LatestServiceDate": "2025-08-31T00:00:00.0000000-07:00"
        }
    ]
    """
    setup(mockJSON: jsonString.data(using: .utf8))

    let result = try await sut.all()

    #expect(result.count == 1)
    #expect(result[0].bookingId == GtfsInfo.sample.bookingId)
    #expect(result[0].updatedDate == GtfsInfo.sample.updatedDate)
    #expect(result[0].earliestServiceDate == GtfsInfo.sample.earliestServiceDate)
    #expect(result[0].latestServiceDate == GtfsInfo.sample.latestServiceDate)
}
```

**Parameterized method** — pass a representative argument matching `.sample`:
```swift
@Test("test .booking() success case")
func booking() async throws {
    let jsonString = """
    {
        "BookingId": "25FASU",
        "UpdatedDate": "2025-05-01T12:00:00.0000000-07:00",
        "EarliestServiceDate": "2025-04-28T00:00:00.0000000-07:00",
        "LatestServiceDate": "2025-08-31T00:00:00.0000000-07:00"
    }
    """
    setup(mockJSON: jsonString.data(using: .utf8))

    let result = try await sut.booking(bookingId: GtfsInfo.sample.bookingId)

    #expect(result.bookingId == GtfsInfo.sample.bookingId)
    #expect(result.updatedDate == GtfsInfo.sample.updatedDate)
    #expect(result.earliestServiceDate == GtfsInfo.sample.earliestServiceDate)
    #expect(result.latestServiceDate == GtfsInfo.sample.latestServiceDate)
}
```

## Step 11 — Add ACTransitClient test

File: `Tests/ACTransitSwiftTests/ACTransitClientTests.swift`

Append a new `@Test` inside the `ACTransitClientTests` suite (before the closing `}`). Call through the client's service property (e.g. `sut.gtfs.all()`). Assert every field against the model's `.sample` static property.

```swift
@Test("test .gtfs.all() success case")
func gtfsAll() async throws {
    let jsonString = """
    [
        {
            "BookingId": "25FASU",
            "UpdatedDate": "2025-05-01T12:00:00.0000000-07:00",
            "EarliestServiceDate": "2025-04-28T00:00:00.0000000-07:00",
            "LatestServiceDate": "2025-08-31T00:00:00.0000000-07:00"
        }
    ]
    """
    setup(mockJSON: jsonString.data(using: .utf8))

    let result = try await sut.gtfs.all()

    #expect(result.count == 1)
    #expect(result[0].bookingId == GtfsInfo.sample.bookingId)
    #expect(result[0].updatedDate == GtfsInfo.sample.updatedDate)
    #expect(result[0].earliestServiceDate == GtfsInfo.sample.earliestServiceDate)
    #expect(result[0].latestServiceDate == GtfsInfo.sample.latestServiceDate)
}
```

## Step 12 — Lint and format

Run both tools to enforce codebase consistency:

```bash
swiftlint --fix Sources Tests
swiftformat Sources Tests
```

## Step 13 — Confirm completion

Report what was created/updated:
- Reference file updated? (yes/no, what changed)
- Model file path
- Endpoint enum updated (file path, case added)
- Service updated (file path, method added)
- Model test file path
- Endpoint test file updated? (yes/no, file path)
- Service test file updated? (yes/no, file path)
- `ACTransitClientTests` updated? (yes/no)

If the endpoint was binary, explain why it was skipped and what would be needed to support it.

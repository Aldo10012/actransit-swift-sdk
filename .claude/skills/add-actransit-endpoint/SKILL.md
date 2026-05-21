---
name: add-actransit-endpoint
description: End-to-end integration of a single AC Transit REST API endpoint into the ACTransitSwift SDK. Adds the endpoint case to ACTEndpoint, generates the Swift model struct, wires ACTClient, and writes tests. Invoke with the endpoint path to add, e.g. "gtfs/all" or "routes/{routeId}/stops".
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

Fetch the live API documentation for the endpoint. Convert the path to the Help URL format by replacing `/` with `-` and replacing any `{param}` segments with the literal text `by-param`:

- `gtfs/all` → `https://api.actransit.org/transit/Help/Api/GET-gtfs-all`
- `routes/{routeId}/stops` → `https://api.actransit.org/transit/Help/Api/GET-routes-by-param-stops`

Fetch that URL and extract:
1. The exact **response JSON sample**
2. The **resource model name** (e.g. `GtfsScheduleInfo`, `Booking`) — look for the type name linked in the response description or in the URL `?modelName=` on the response type link
3. All **path parameters** and their types
4. All **query parameters** beyond `token`
5. Whether the response is **binary** (ZIP / protobuf) rather than JSON

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

From the path (e.g. `gtfs/all`), derive:

| Artifact | Rule | Example |
|---|---|---|
| Endpoint case name | camelCase of path segments, params become labels | `gtfsAll`, `gtfs(bookingId:)` |
| Client method name | `get` + PascalCase of path segments | `getGtfsAll`, `getGtfsBooking(bookingId:)` |
| Model file name | resource model name from API docs | `GtfsScheduleInfo.swift` |
| Test file name | model name + `Tests` | `GtfsScheduleInfoTests.swift` |

For path parameters, name the associated value after the parameter (e.g. `case gtfsBooking(bookingId: String)`).

## Step 5 — Generate the Swift model

Invoke the `swift-struct-generator` skill with:
- The **exact JSON sample** from the live API docs
- The **resource model name** as the required struct name
- The instruction that all types must be `public`, `Codable`, and `Sendable`
- Note any date fields (ISO 8601 with potential 7 fractional-second digits) so the generator handles them with a custom decoder using `ISO8601DateFormatter.ACTFormat` from the shared extension — never declare a new per-struct formatter

Above the struct declaration, add a `///` doc comment with the API doc URL:

```swift
/// https://api.actransit.org/transit/Help/Api/GET-gtfs-all
public struct GtfsInfo: Codable, Sendable {
```

Write the generated file to:
```
Sources/ACTransitSwift/Models/{ModelName}.swift
```

## Step 6 — Update ACTEndpoint.swift

File: `Sources/ACTransitSwift/ACTEndpoint.swift`

Add the new case to the `ACTEndpoint` enum and extend both switch statements:

Above each new case, add a `///` doc comment with the API doc URL:

**Standard (no path params):**
```swift
/// https://api.actransit.org/transit/Help/Api/GET-gtfs-all
case gtfsAll

// path switch:
case .gtfsAll: "/gtfs/all"

// getRequest(token:) switch:
case .gtfsAll:
    factory.build(httpMethod: .GET, baseUrlString: url, parameters: [apiTokenQueryParameter])
```

**Parameterized:**
```swift
/// https://api.actransit.org/transit/Help/Api/GET-gtfs-by-param
case gtfsBooking(bookingId: String)

// path switch:
case .gtfsBooking(let bookingId): "/gtfs/\(bookingId)"

// getRequest(token:) switch:
case .gtfsBooking:
    factory.build(httpMethod: .GET, baseUrlString: url, parameters: [apiTokenQueryParameter])
```

**Extra query params** (e.g. a `limit` param): add additional `HTTPParameter` values to the `parameters` array.

## Step 7 — Update ACTClient.swift

File: `Sources/ACTransitSwift/ACTClient.swift`

Add a `public func` that calls through to the endpoint. Match the method signature to the endpoint classification:

**Standard:**
```swift
public func getGtfsAll() async throws -> [GtfsScheduleInfo] {
    try await performer.perform(request: ACTEndpoint.gtfsAll.getRequest(token: token), decodeTo: [GtfsScheduleInfo].self)
}
```

**Parameterized:**
```swift
public func getGtfsBooking(bookingId: String) async throws -> GtfsScheduleInfo {
    try await performer.perform(request: ACTEndpoint.gtfsBooking(bookingId: bookingId).getRequest(token: token), decodeTo: GtfsScheduleInfo.self)
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

## Step 9 — Update ACTEndpointTests

File: `Tests/ACTransitSwiftTests/ACTEndpointTests.swift`

Add a `@Test` for the new endpoint case following the same pattern as the existing `gtfs()` test:

```swift
@Test("test ACTEndpoint.gtfsAll")
func gtfsAll() {
    let endpoint = ACTEndpoint.gtfsAll
    let request = endpoint.getRequest(token: Constants.mockToken)

    #expect(endpoint.path == "/gtfs/all")
    #expect(request.httpMethod == .GET)
    #expect(request.baseUrl == "https://api.actransit.org/transit/gtfs/all")
    #expect(request.parameters == [HTTPParameter(key: Constants.tokenKey, value: Constants.mockToken)])
}
```

For parameterized endpoints, pass a representative value to the case and verify the path contains it:

```swift
@Test("test ACTEndpoint.gtfsBooking")
func gtfsBooking() {
    let endpoint = ACTEndpoint.gtfsBooking(bookingId: "25FASU")
    let request = endpoint.getRequest(token: Constants.mockToken)

    #expect(endpoint.path == "/gtfs/25FASU")
    #expect(request.httpMethod == .GET)
    #expect(request.baseUrl == "https://api.actransit.org/transit/gtfs/25FASU")
    #expect(request.parameters == [HTTPParameter(key: Constants.tokenKey, value: Constants.mockToken)])
}
```

## Step 10 — Add ACTClient success test

File: `Tests/ACTransitSwiftTests/ACTClientTests.swift`

Append a new `@Test` inside the `ACTClientTests` suite (before the closing `}`). The mock JSON must use the same PascalCase keys the API returns. Assert every field against the model's `.sample` static property — do **not** use a `decode` helper that decodes to a specific type.

**Standard (single object) response:**
```swift
@Test("test .getGtfs() success case")
func getGtfs() async throws {
    let jsonString = """
    {
        "UpdatedDate": "2025-05-01T12:00:00.0000000-07:00",
        "EarliestServiceDate": "2025-04-28T00:00:00.0000000-07:00",
        "LatestServiceDate": "2025-08-31T00:00:00.0000000-07:00"
    }
    """
    setup(mockJSON: jsonString.data(using: .utf8))

    let result = try await sut.getGtfs()

    #expect(result.updatedDate == GtfsScheduleInfo.sample.updatedDate)
    #expect(result.earliestServiceDate == GtfsScheduleInfo.sample.earliestServiceDate)
    #expect(result.latestServiceDate == GtfsScheduleInfo.sample.latestServiceDate)
}
```

**Array response** — wrap in `[…]`, assert `count == 1`, index into `result[0]`:
```swift
@Test("test .getGtfsAll() success case")
func getGtfsAll() async throws {
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

    let result = try await sut.getGtfsAll()

    #expect(result.count == 1)
    #expect(result[0].bookingId == GtfsInfo.sample.bookingId)
    #expect(result[0].updatedDate == GtfsInfo.sample.updatedDate)
    #expect(result[0].earliestServiceDate == GtfsInfo.sample.earliestServiceDate)
    #expect(result[0].latestServiceDate == GtfsInfo.sample.latestServiceDate)
}
```

**Parameterized method** — pass a representative argument matching `.sample`:
```swift
@Test("test .getGtfsBooking() success case")
func getGtfsBooking() async throws {
    let jsonString = """
    {
        "BookingId": "25FASU",
        "UpdatedDate": "2025-05-01T12:00:00.0000000-07:00",
        "EarliestServiceDate": "2025-04-28T00:00:00.0000000-07:00",
        "LatestServiceDate": "2025-08-31T00:00:00.0000000-07:00"
    }
    """
    setup(mockJSON: jsonString.data(using: .utf8))

    let result = try await sut.getGtfsBooking(bookingId: GtfsInfo.sample.bookingId)

    #expect(result.bookingId == GtfsInfo.sample.bookingId)
    #expect(result.updatedDate == GtfsInfo.sample.updatedDate)
    #expect(result.earliestServiceDate == GtfsInfo.sample.earliestServiceDate)
    #expect(result.latestServiceDate == GtfsInfo.sample.latestServiceDate)
}
```

Use the correct date format from the sample data. For non-date fields, use the literal value from `.sample` directly in the JSON string.

## Step 11 — Lint and format

Run both tools to enforce codebase consistency:

```bash
swiftlint --fix Sources Tests
swiftformat Sources Tests
```

## Step 12 — Confirm completion

Report what was created/updated:
- Reference file updated? (yes/no, what changed)
- Model file path
- Endpoint case added
- Client method added
- Model test file path
- `ACTEndpointTests` updated? (yes/no)
- `ACTClientTests` updated? (yes/no)

If the endpoint was binary, explain why it was skipped and what would be needed to support it.

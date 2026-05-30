---
name: add-actransit-group
description: Adds all endpoints for a single AC Transit API resource group into the SDK. Reads the group's reference file to enumerate every endpoint, implements each one in order (one commit per endpoint), then opens a PR. Invoke with the group name, e.g. "routes", "stops", "vehicles".
---

# Add AC Transit Group

Adds full SDK support for every endpoint in one AC Transit API resource group. The argument is the **group name** (first path segment), e.g. `routes`, `gtfs`, `trips`, `stops`, `vehicles`, `actrealtime`, `gtfsrt`.

> **IMPORTANT — Do NOT call `/add-actransit-endpoint` from inside this skill.** Nested skill invocations break the loop — control returns to the user after the sub-skill finishes instead of continuing to the next endpoint. All endpoint implementation steps are inlined directly in Step 4 below.

---

## Step 1 — Read the reference file

Determine the reference file from the group name:

| Group | Reference file |
|---|---|
| `gtfs` | `@../../ac-transit-api/references/gtfs.md` |
| `routes` | `@../../ac-transit-api/references/routes.md` |
| `trips` | `@../../ac-transit-api/references/trips.md` |
| `stops` | `@../../ac-transit-api/references/stops.md` |
| `vehicles` | `@../../ac-transit-api/references/vehicles.md` |
| `actrealtime` | `@../../ac-transit-api/references/act-realtime.md` |
| `gtfsrt` | `@../../ac-transit-api/references/gtfs-realtime.md` |

Read the matching file and extract every endpoint path from the `` ## `GET /...` `` headings, **in document order**. Strip the leading `/` from each path. These are your work list.

> **Note:** A group's reference file may contain paths with different prefixes. For example, the `routes` reference file contains both `routes/{booking}` (list all) and `route/{routeName}/trips` (single route). Both belong to this group and must be included.

Example — for the `routes` group the work list would be:
```
routes/{booking}
route/{routeName}/{booking}
route/{routeName}/trips
route/{routeName}/tripsinstructions
route/{routeName}/directions
route/{routeName}/stops/{booking}
route/{routeName}/trip/{tripId}/pattern
route/{routeName}/trip/{tripId}/stops
route/{routeName}/vehicles
route/{routeName}/tripestimate
route/{routes}/waypoints/{booking}
route/{routes}/waypointsfast/{booking}
route/{routes}/tripstoday
route/{routes}/tripstops
route/{routes}/timetable/{direction}
route/{routes}/schedule/{booking}
route/{routeName}/destinations
route/{routes}/exceptions/{booking}
route/{routes}/profile
```

---

## Step 2 — Verify a clean working tree

Before making any changes, confirm there are no uncommitted modifications:

```bash
git status --porcelain
```

If the output is non-empty, stop and tell the user to commit or stash their changes first.

---

## Step 3 — Create a feature branch

Create (or resume) a branch named after the group:

```bash
git checkout -b feat/add-{group}-endpoints 2>/dev/null || git checkout feat/add-{group}-endpoints
```

The `||` fallback lets the skill resume safely if the branch already exists from a previous partial run.

---

## Step 4 — Process each endpoint

Work through the endpoint list **one at a time**, in order. For each path:

### 4a — Check if already implemented

Read `Sources/ACTransitSwift/Endpoints/{Group}Endpoint.swift` (if it exists). Search the `path` computed property's switch statement for a string literal that contains the non-parameter segments of the current path.

To find the non-parameter segments: take the path, drop any `{…}` segments, and check if the remaining literal parts all appear together in a single `case` line of the path switch.

Examples:
- `route/{routeName}/trips` → look for a path case containing both `route/` and `/trips`
- `routes/{booking}` → look for a path case containing `routes/` (and no further static segments after it)
- `route/{routeName}/trip/{tripId}/pattern` → look for a path case containing `route/`, `/trip/`, and `/pattern`

If a matching case is found, **skip silently** — add the path to the skipped-existing list and move to the next endpoint.

### 4b — Cross-reference the live API docs

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
2. The **resource model name** — look for the `?modelName=` link in the response description (e.g. `RouteDivision`, `GtfsScheduleInfo`)
3. All **path parameters**, their types, and full descriptions
4. All **query parameters** beyond `token` — names, types, required vs optional, typed enum values, and full descriptions
5. Whether the response is **binary** (ZIP / protobuf) rather than JSON

**Call the actual API to verify** — if an API token is available, call the live endpoint and confirm the response shape matches the docs. Use real response values for `.sample` data, not placeholder strings.

**Verify and update the reference file** — if the live docs or live response reveal discrepancies (missing fields, wrong types, different model name), update the reference file before proceeding.

### 4c — Classify the endpoint

- **Binary response**: log a note, add to the skipped-binary list, and move to the next endpoint.
- **JSON response**: proceed to 4d.

### 4d — Implement the endpoint

Follow the same patterns as the existing `GTFSEndpoint`, `GTFSService`, `GtfsInfo`, and their tests.

**Resolve named types from the ResourceModel page** — When a field's type on the ResourceModel page is a named type (not a Swift primitive like `string`, `integer`, `boolean`), fetch `https://api.actransit.org/transit/Help/ResourceModel?modelName={TypeName}` to get the full definition before writing any Swift code.

- **Enum types** (e.g. `TripScheduleType`): Create a Swift enum in the endpoint file with the correct raw values from the API docs. Note: the API may use integer values in JSON responses but accept string values for query parameters — handle both in one enum:
  ```swift
  public enum TripScheduleType: Int, Codable, Sendable {
      case weekday = 0   // API JSON value
      case saturday = 5
      case sunday = 6

      /// String value used when passing this type as a query parameter.
      var queryValue: String {
          switch self {
          case .weekday: "Weekday"
          case .saturday: "Saturday"
          case .sunday: "Sunday"
          }
      }
  }
  ```
  In `getRequest(token:)`, use `.queryValue` (not `.rawValue`) when building query parameters for these enums. In model structs, use the enum type directly (e.g. `public let scheduleType: TripScheduleType`) — never use `Int` or `String` when the API doc names a typed enum.
- **Nested object types**: Generate a separate `public struct` for each (can live in the same `.swift` file if tightly coupled).

**Generate the Swift model** — based on the JSON sample and resource model name:
- `public struct`, `Codable`, `Sendable`
- CodingKeys using PascalCase API key names
- Named enum fields use the enum type (never a bare `Int` or `String` when the API doc names a typed enum)
- Custom `init(from:)` only for models with date fields (use `ISO8601DateFormatter.ACTFormat` via the shared extension — never declare a new per-struct formatter)
- Static `.sample`, `.minimal` (if optional fields exist), and `.make(…)` factory
- `.sample` values must use **real data from a live API call**, not placeholder strings
- Doc comment `/// https://api.actransit.org/transit/Help/ResourceModel?modelName={ModelName}` above the struct declaration
- For each property, fetch the ResourceModel page and add a `///` doc comment with the API's description. Only add a doc comment if the API docs provide a description for that property — omit it if they don't.
- Write to `Sources/ACTransitSwift/DTOs/{ModelName}.swift`

**If the response is `[String]`** (directions endpoint), no model file is needed.

**Update the endpoint enum** (`Sources/ACTransitSwift/Endpoints/{Group}Endpoint.swift`):
- Create the file if this is the first endpoint for the group, following the pattern of `GTFSEndpoint.swift`
- Add a `///` doc comment with the **actual API endpoint URL** above the new case — NOT the Help URL
  - Format: `/// https://api.actransit.org/transit/{path}?{queryParams}` (only include non-token params)
  - Example: `/// https://api.actransit.org/transit/routes/{booking}?sortType={sortType}`
- Below the URL comment, add `/// - Parameters:` docstrings for each associated value, copied from the API docs description
- Use typed Swift enums for typed API parameters; define them in the endpoint file
- For enum query params, use `.queryValue` (not `.rawValue`) when building `HTTPParameter` values
- Optional path params (bookingId, etc.) should use `= nil` defaults on the associated value
- Required query params should be non-optional associated values
- Extend both switch statements: `path` and `getRequest(token:)`

**Update the service** (`Sources/ACTransitSwift/Services/{Group}Service.swift`):
- Create the file if this is the first endpoint for the group, following the pattern of `GTFSService.swift`
- If the service file is new, also add `public let {group}: {Group}Service` to `ACTransitClient` and initialize it in `init(token:performer:)`
- Add the `public func` method with a `///` doc comment: one summary line followed by `/// - Parameters:` for each argument, with descriptions copied from the API docs

**Write model tests** (`Tests/ACTransitSwiftTests/DTOs/{ModelName}Tests.swift`):
- Only needed for models with custom `init(from:)` decoders (i.e. date fields)
- `@Suite("Test {ModelName}")` — name must start with `"Test "`
- Cover: decode happy path, 7-digit fractional seconds, empty array, malformed date throws, encode PascalCase keys, round-trip, `.sample` sanity check, `.make()` override

**Update endpoint tests** (`Tests/ACTransitSwiftTests/Endpoints/{Group}EndpointTests.swift`):
- Create the file if new, following `GTFSEndpointTests.swift`
- Add a `@Test` for the new case; verify `path`, `httpMethod`, `baseUrl`, and `parameters`
- Use `(request.parameters ?? []).contains(…)` when checking for specific params alongside others

**Update service tests** (`Tests/ACTransitSwiftTests/Services/{Group}ServiceTests.swift`):
- Create the file if new, following `GTFSServiceTests.swift`
- Add a `@Test` with mock JSON using PascalCase keys; assert every field against `.sample`

**Update ACTransitClient tests** (`Tests/ACTransitSwiftTests/ACTransitClientTests.swift`):
- Add one `@Test` that calls through `sut.{group}.{method}(…)` and asserts against `.sample`
- Only needed for the **first** endpoint of a new group (or one representative endpoint per group)

**Run lint and format:**
```bash
swiftlint --fix Sources Tests
swiftformat Sources Tests
```

### 4e — Commit (one commit per endpoint, no exceptions)

After implementing the endpoint, stage and commit **immediately**:

```bash
git add Sources Tests .claude
git commit -m "feat: add {path} endpoint"
```

> **One commit per endpoint is required.** Do not batch multiple endpoints into a single commit. Do not wait until the end to commit. Each commit must contain exactly the changes for one endpoint (its model, enum case, service method, and tests).

Add the path to the added list and proceed to the next endpoint.

---

## Step 5 — Verify build and tests

After all endpoints have been processed, run a full build and test suite to confirm nothing is broken before opening the PR:

```bash
swift build 2>&1
swift test 2>&1
```

If either command fails, **stop**. Do not open a PR. Report the failure output and tell the user which commit introduced the breakage (use `git log --oneline` to identify it).

---

## Step 6 — Open a pull request

Push the branch and open a PR:

```bash
git push -u origin feat/add-{group}-endpoints
```

Then create the PR using `gh`, filling in the actual counts and path lists:

```bash
gh pr create \
  --title "feat: add {group} endpoints" \
  --body "$(cat <<'EOF'
## Summary

Adds SDK support for all `{group}` API endpoints.

### Added ({N} endpoints)
{bullet list of added paths}

### Skipped — binary response ({N} endpoints)
{bullet list of binary paths, or "None"}

### Skipped — already implemented ({N} endpoints)
{bullet list of already-existing paths, or "None"}

## Test plan
- [ ] `swift build` passes
- [ ] `swift test` passes (all suites green)
- [ ] Each new model decodes the live API response sample correctly
- [ ] Each new endpoint test verifies path, HTTP method, base URL, and token parameter

🤖 Generated with [Claude Code](https://claude.com/claude-code)
EOF
)"
```

---

## Step 7 — Report completion

Print a final summary:

```
Group: {group}
Branch: feat/add-{group}-endpoints
PR: {PR URL}

Added ({N}):
  ✓ {path}
  ✓ {path}
  ...

Skipped — binary ({N}):
  ✗ {path}
  ...

Skipped — already implemented ({N}):
  ↩ {path}
  ...
```

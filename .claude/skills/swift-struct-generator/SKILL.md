---
name: swift-struct-generator
description: Generate production-ready Swift structs from JSON. Use this skill whenever the user provides a JSON string, JSON snippet, or API response and wants Swift model types, Codable structs, or Swift data models generated from it. Trigger even if the user just pastes JSON without explicitly asking for "structs" — if there's JSON and a Swift project context, this skill applies.
---

# Swift Struct Generator

Convert a JSON string into production-ready Swift code. The goal is code that a senior iOS engineer would be comfortable shipping — well-typed, idiomatic, and immediately usable in any Swift/iOS project.

## What to produce

### 1. Swift Structs

- One `struct` per JSON object, with precisely typed properties matching the JSON structure
- `Codable` conformance on every type
- Custom `CodingKeys` whenever JSON keys don't match Swift `camelCase` naming (e.g. `"transit_stop_id"` → `transitStopId`)
- Nested structs for nested objects — keep them modular and named clearly, not anonymous
- Use `[String: SomeType]` dictionaries for objects with dynamic/unknown keys

### 2. Type Handling

Match Swift types to JSON types precisely:

| JSON type | Swift type |
|-----------|-----------|
| string | `String` |
| number (integer) | `Int` |
| number (decimal) | `Double` |
| boolean | `Bool` |
| array | `[ElementType]` |
| null / sometimes-absent field | optional (`?`) |
| field that is sometimes one type, sometimes another | `AnyCodable` or a custom enum with associated values |

For fields that can be `null` in the JSON, always use optionals. For fields that are simply absent on some responses, also use optionals. Don't assume a field is always present unless the JSON makes it unambiguous.

### 3. Custom Encoding & Decoding

Implement custom `init(from:)` / `encode(to:)` when the default synthesis can't handle the shape:

- **Date fields**: store as `Date`, not `String`. Use the shared formatters from `Extensions/ISO8601DateFormatter+Extensions.swift` — **do not** declare a new per-struct formatter:
  - `ISO8601DateFormatter.ACTFormat` — internet date-time **with** fractional seconds; use for encoding/decoding API response date fields
  - `ISO8601DateFormatter.ACTQueryFormat` — internet date-time **without** fractional seconds; use for formatting query parameter dates and constructing `sample` mock data
  - The AC Transit API can return up to 7 fractional-second digits; normalize to 3 before parsing with: `string.replacingOccurrences(of: #"(\.\d{3})\d+"#, with: "$1", options: .regularExpression)`
- **URL fields**: decode as `URL` with graceful fallback
- **Enum string mapping**: write a `RawRepresentable` enum with `String` raw values and `unknownCase` fallback
- **Malformed values**: use `decodeIfPresent` + nil coalescing rather than crashing

Only add custom decode/encode where the default synthesis is insufficient — don't add boilerplate for the common case.

### 4. Code Style

- `camelCase` for all properties
- `CapitalCase` for all type names
- Add a `///` doc comment only when a property name is ambiguous or the domain meaning is non-obvious
- No redundant comments, no "this is a struct for X" comments
- Keep each type in its own logical block; order: properties → `CodingKeys` → custom init/encode (if any) → static sample data

### 5. Mock Data & Preview Support

After each struct (or in a `extension` at the bottom of the file), provide:

- A `static let sample: MyType` with realistic, fully populated data
- A `static let minimal: MyType` with only required (non-optional) fields set; optionals as `nil`
- A `static let empty: MyType` where arrays are `[]` and strings are `""` — useful for testing empty-state UI

Place these as `static` properties directly on the struct or in an `#if DEBUG` extension. Label the section with a `// MARK: - Mock Data` comment.

### 6. Unit Test Utilities

Below the mock data, add:

- A static factory method `static func make(...)` that accepts every property as a parameter with defaults drawn from `sample` — so tests can override just what they care about
- This pattern makes test setup one line per test

**Example:**
```swift
static func make(
    id: Int = sample.id,
    name: String = sample.name,
    stops: [Stop] = sample.stops
) -> Route {
    Route(id: id, name: name, stops: stops)
}
```

## Output format

**One struct per file.** Each Swift type (struct) gets its own file named `TypeName.swift`. Never place two struct definitions in the same file — not even a parent and its child.

- If the JSON has nested objects, generate one file per struct: `ParentType.swift`, `ChildType.swift`, etc.
- Typealiases (e.g. `public typealias RequestResponseOfFoo = BusTimeResponse<Foo>`) are not structs and may live in the same file as the struct they wrap.
- For each file, the order is:

1. `import Foundation` (and `SwiftUI` only if the user's project uses it)
2. The single struct, with properties → `CodingKeys` → custom init/encode (if any)
3. `// MARK: - Mock Data` section at the bottom

When generating output, list every file separately with its filename as a header.

## Example

**Input JSON:**
```json
{
  "route_id": "51B",
  "display_name": "Berkeley - Fruitvale BART",
  "is_active": true,
  "stops": [
    { "stop_id": 1001, "label": "Fruitvale BART", "lat": 37.774, "lon": -122.224 }
  ]
}
```

**Output — two separate files:**

**`Stop.swift`**
```swift
import Foundation

struct Stop: Codable {
    let stopId: Int
    let label: String
    let lat: Double
    let lon: Double

    enum CodingKeys: String, CodingKey {
        case stopId = "stop_id"
        case label
        case lat
        case lon
    }

    // MARK: - Mock Data

    static let sample = Stop(stopId: 1001, label: "Fruitvale BART", lat: 37.774, lon: -122.224)

    static func make(
        stopId: Int = sample.stopId,
        label: String = sample.label,
        lat: Double = sample.lat,
        lon: Double = sample.lon
    ) -> Stop {
        Stop(stopId: stopId, label: label, lat: lat, lon: lon)
    }
}
```

**`Route.swift`**
```swift
import Foundation

struct Route: Codable {
    let routeId: String
    let displayName: String
    let isActive: Bool
    let stops: [Stop]

    enum CodingKeys: String, CodingKey {
        case routeId = "route_id"
        case displayName = "display_name"
        case isActive = "is_active"
        case stops
    }

    // MARK: - Mock Data

    static let sample = Route(
        routeId: "51B",
        displayName: "Berkeley - Fruitvale BART",
        isActive: true,
        stops: [.sample]
    )

    static let minimal = Route(routeId: "1", displayName: "", isActive: false, stops: [])

    static func make(
        routeId: String = sample.routeId,
        displayName: String = sample.displayName,
        isActive: Bool = sample.isActive,
        stops: [Stop] = sample.stops
    ) -> Route {
        Route(routeId: routeId, displayName: displayName, isActive: isActive, stops: stops)
    }
}
```

## How to handle ambiguous input

- If a JSON field could be `Int` or `String` (e.g. `"id"` is `"42"` in one place and `42` in another), model it as `String` and note the inconsistency with a `///` comment
- If the JSON is truncated or has `...` placeholders, ask the user for the full shape before generating
- If a field name collides with a Swift keyword (e.g. `"default"`, `"class"`), use backtick escaping in `CodingKeys` raw value and pick a safe Swift property name

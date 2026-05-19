# Vehicles — Static Characteristics and Real-Time Occupancy

---

## `GET /vehicle/{vehicleId}`

Returns real-time location and status for a single vehicle.

**Path Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| vehicleId | integer | Yes | Vehicle identifier |

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| token | string | Yes | API authentication token |

**Response Body**

| Field | Type | Description |
|-------|------|-------------|
| VehicleId | integer | Vehicle identifier |
| CurrentTripId | integer | Active trip ID (if in service) |
| Latitude | decimal | Geographic latitude (nullable) |
| Longitude | decimal | Geographic longitude (nullable) |
| Heading | integer | Direction in degrees (nullable) |
| TimeLastReported | datetime | Most recent data timestamp (nullable) |

> Real-time data is only supplied when the vehicle is actively servicing a route.

---

## `GET /vehicle/characteristics`

Returns physical and operational specifications for one or all active vehicles.

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| vehicleId | string | No | Vehicle (bus) number; omit to retrieve all active vehicles |
| token | string | Yes | API authentication token |

**Response Body**

| Field | Type | Description |
|-------|------|-------------|
| VehicleId | string | Bus number |
| IsActive | boolean | Active fleet status |
| Description | string | Vehicle description |
| VehicleType | string | Vehicle type code |
| VehicleTypeDescription | string | Vehicle type description |
| Make | string | Manufacturer |
| SerialNumber | string | Serial number |
| LicenseNumber | string | License plate |
| Length | string | Length in feet |
| PropulsionType | string | Propulsion type (diesel, electric, etc.) |
| HasWiFi | boolean | Wi-Fi available |
| HasAC | boolean | Air conditioning available |
| StandingCapacity | string | Standing capacity (numeric, nullable) |
| SeatingCapacity | string | Seating capacity (numeric, nullable) |
| LimitCapacity | string | Agency-enforced passenger limit |

---

## `GET /vehicle/{vehicleId}/characteristics`

Returns physical and operational specifications for a specific vehicle.

**Path Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| vehicleId | string | Yes | Vehicle (bus) number |

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| token | string | Yes | API authentication token |

**Response Body** — Same structure as `GET /vehicle/characteristics` (single VehicleCharacteristics object, not array).

---

## `GET /vehicle/realtimeattributes`

Returns real-time position and passenger occupancy data for one or more vehicles.

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| vehicleId | string | No | Vehicle (bus) number filter |
| routename | string | No | Route name filter |
| token | string | Yes | API authentication token |

**Response Body**

| Field | Type | Description |
|-------|------|-------------|
| VehicleId | string | Bus number |
| CurrentRoute | string | Route currently being serviced |
| LastPositionLatitude | decimal | Last known latitude (nullable) |
| LastPositionLongitude | decimal | Last known longitude (nullable) |
| DateTimePositionReported | datetime | Last position report timestamp (PST/PDT, nullable) |
| VehicleCapacity | integer | Maximum passenger capacity (nullable) |
| CurrentPassengerCount | integer | Current passenger count (nullable) |
| EstimatedOccupancyPercentage | integer | Occupancy percentage (nullable) |
| EstimatedOccupancyStatusColor | string | Hex RGB color for occupancy status (nullable) |
| EstimatedOccupancyStatus | string | `Not Crowded`, `Some Crowding`, or `Crowded` (nullable) |
| DateTimeAPCReported | datetime | Last APC occupancy report timestamp (nullable) |

---

## `GET /vehicle/{vehicleId}/realtimeattributes`

Returns real-time attributes for a specific vehicle on a specific route.

**Path Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| vehicleId | string | Yes | Vehicle (bus) number |
| routename | string | Yes | Route name |

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| token | string | Yes | API authentication token |

**Response Body** — Same structure as `GET /vehicle/realtimeattributes` (single VehicleRealtimeAttributes object).

---

## `GET /vehicle/route/{routename}/realtimeattributes`

Returns real-time attributes for vehicles on a specific route, optionally filtered by vehicle ID.

**Path Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| routename | string | Yes | Route name identifier |

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| vehicleId | string | No | Optional vehicle ID filter |
| token | string | Yes | API authentication token |

**Response Body** — Same structure as `GET /vehicle/realtimeattributes`.

---

## `POST /vehicle/realtimeattributes`

Returns real-time attributes for multiple vehicles specified in the request body.

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| token | string | Yes | API authentication token |

**Request Body** (`application/json`)

```json
{
  "Vehicles": ["string", "string"],
  "Route": "string"
}
```

| Field | Type | Description |
|-------|------|-------------|
| Vehicles | string[] | Collection of vehicle IDs (bus numbers) |
| Route | string | Route name (e.g., `72`) |

**Response Body** — Array of VehicleRealtimeAttributes objects (same structure as `GET /vehicle/realtimeattributes`).
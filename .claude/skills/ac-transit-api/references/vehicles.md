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

**Response Sample (JSON):**

```json
{
  "VehicleId": 1,
  "CurrentTripId": 2,
  "Latitude": 1.0,
  "Longitude": 1.0,
  "Heading": 1,
  "TimeLastReported": "2026-05-21T18:01:17.1536026-07:00"
}
```

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

**Response Sample (JSON):**

```json
{
  "VehicleId": "sample string 1",
  "IsActive": true,
  "Description": "sample string 3",
  "VehicleType": "sample string 4",
  "VehicleTypeDescription": "sample string 5",
  "Make": "sample string 6",
  "SerialNumber": "sample string 7",
  "LicenseNumber": "sample string 8",
  "Length": "sample string 9",
  "PropulsionType": "sample string 10",
  "HasWiFi": true,
  "HasAC": true,
  "StandingCapacity": "sample string 13",
  "SeatingCapacity": "sample string 14",
  "LimitCapacity": "sample string 15"
}
```

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

**Response Sample (JSON):**

```json
{
  "VehicleId": "sample string 1",
  "IsActive": true,
  "Description": "sample string 3",
  "VehicleType": "sample string 4",
  "VehicleTypeDescription": "sample string 5",
  "Make": "sample string 6",
  "SerialNumber": "sample string 7",
  "LicenseNumber": "sample string 8",
  "Length": "sample string 9",
  "PropulsionType": "sample string 10",
  "HasWiFi": true,
  "HasAC": true,
  "StandingCapacity": "sample string 13",
  "SeatingCapacity": "sample string 14",
  "LimitCapacity": "sample string 15"
}
```

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

**Response Sample (JSON):**

```json
{
  "VehicleId": "sample string 1",
  "CurrentRoute": "sample string 2",
  "LastPositionLatitude": 1.1,
  "LastPositionLongitude": 1.1,
  "DateTimePositionReported": "2026-05-21T18:02:29.8646608-07:00",
  "VehicleCapacity": 1,
  "CurrentPassengerCount": 1,
  "EstimatedOccupancyPercentage": 1,
  "EstimatedOccupancyStatusColor": "sample string 3",
  "EstimatedOccupancyStatus": "sample string 4",
  "DateTimeAPCReported": "2026-05-21T18:02:29.8646608-07:00"
}
```

---

## `GET /vehicle/{vehicleId}/realtimeattributes`

Returns real-time attributes for a specific vehicle, optionally filtered by route.

**Path Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| vehicleId | string | Yes | Vehicle (bus) number |

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| routename | string | No | Route name filter |
| token | string | Yes | API authentication token |

**Response Body** — Single VehicleRealtimeAttributes object (same fields as `GET /vehicle/realtimeattributes`).

**Response Sample (JSON):**

```json
{
  "VehicleId": "sample string 1",
  "CurrentRoute": "sample string 2",
  "LastPositionLatitude": 1.1,
  "LastPositionLongitude": 1.1,
  "DateTimePositionReported": "2026-05-21T07:16:57.1593549-07:00",
  "VehicleCapacity": 1,
  "CurrentPassengerCount": 1,
  "EstimatedOccupancyPercentage": 1,
  "EstimatedOccupancyStatusColor": "sample string 3",
  "EstimatedOccupancyStatus": "sample string 4",
  "DateTimeAPCReported": "2026-05-21T07:16:57.1593549-07:00"
}
```

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

**Response Sample (JSON):**

```json
{
  "VehicleId": "sample string 1",
  "CurrentRoute": "sample string 2",
  "LastPositionLatitude": 1.1,
  "LastPositionLongitude": 1.1,
  "DateTimePositionReported": "2026-05-21T08:22:15.639476-07:00",
  "VehicleCapacity": 1,
  "CurrentPassengerCount": 1,
  "EstimatedOccupancyPercentage": 1,
  "EstimatedOccupancyStatusColor": "sample string 3",
  "EstimatedOccupancyStatus": "sample string 4",
  "DateTimeAPCReported": "2026-05-21T08:22:15.639476-07:00"
}
```

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

**Response Sample (JSON):**

```json
{
  "VehicleId": "sample string 1",
  "CurrentRoute": "sample string 2",
  "LastPositionLatitude": 1.1,
  "LastPositionLongitude": 1.1,
  "DateTimePositionReported": "2026-05-21T14:23:05.9520948-07:00",
  "VehicleCapacity": 1,
  "CurrentPassengerCount": 1,
  "EstimatedOccupancyPercentage": 1,
  "EstimatedOccupancyStatusColor": "sample string 3",
  "EstimatedOccupancyStatus": "sample string 4",
  "DateTimeAPCReported": "2026-05-21T14:23:05.9520948-07:00"
}
```
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

**Response Sample (JSON):** — array of objects

```json
[
  {
    "VehicleId": "1342",
    "IsActive": true,
    "Description": "BUS: 2012, GILLIG, URBAN, 40'",
    "VehicleType": "06",
    "VehicleTypeDescription": "ST40 - Standard 40",
    "Make": "GILLIG",
    "SerialNumber": "15GGD2716D1182194",
    "LicenseNumber": "1177753",
    "Length": "40.00",
    "PropulsionType": "DIESEL FUEL",
    "HasWiFi": false,
    "HasAC": true,
    "StandingCapacity": "43",
    "SeatingCapacity": "37",
    "LimitCapacity": "47"
  }
]
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

**Response Body** — Same structure as `GET /vehicle/characteristics`. Returns a one-element **array** even for a specific vehicle.

**Response Sample (JSON):**

```json
[
  {
    "VehicleId": "1676",
    "IsActive": true,
    "Description": "BUS: 2022, GILLIG, URBAN, 40'",
    "VehicleType": "06",
    "VehicleTypeDescription": "ST40 - Standard 40",
    "Make": "GILLIG",
    "SerialNumber": "15GGD2710N3197800",
    "LicenseNumber": "1566696",
    "Length": "40.00",
    "PropulsionType": "DIESEL FUEL",
    "HasWiFi": false,
    "HasAC": true,
    "StandingCapacity": "43",
    "SeatingCapacity": "37",
    "LimitCapacity": "47"
  }
]
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

**Response Sample (JSON):** — array of objects

```json
[
  {
    "VehicleId": "1354",
    "CurrentRoute": "96",
    "LastPositionLatitude": 37.79370880126953,
    "LastPositionLongitude": -122.24005126953125,
    "DateTimePositionReported": "2026-05-24T16:45:55.9669661-07:00",
    "VehicleCapacity": 47,
    "CurrentPassengerCount": null,
    "EstimatedOccupancyPercentage": null,
    "EstimatedOccupancyStatusColor": "#00b33c",
    "EstimatedOccupancyStatus": "Not Crowded",
    "DateTimeAPCReported": "2026-05-24T16:45:55.9669661-07:00"
  }
]
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

**Response Body** — **Array** of VehicleRealtimeAttributes objects (same fields as `GET /vehicle/realtimeattributes`). Returns a one-element array even for a specific vehicle.

**Response Sample (JSON):**

```json
[
  {
    "VehicleId": "1676",
    "CurrentRoute": "51A",
    "LastPositionLatitude": 37.76605224609375,
    "LastPositionLongitude": -122.24343872070313,
    "DateTimePositionReported": "2026-05-24T16:46:26.7424664-07:00",
    "VehicleCapacity": 47,
    "CurrentPassengerCount": null,
    "EstimatedOccupancyPercentage": null,
    "EstimatedOccupancyStatusColor": "#00b33c",
    "EstimatedOccupancyStatus": "Not Crowded",
    "DateTimeAPCReported": "2026-05-24T16:46:26.7424664-07:00"
  }
]
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

**Response Body** — **Array** of VehicleRealtimeAttributes objects (same fields as `GET /vehicle/realtimeattributes`).

**Response Sample (JSON):**

```json
[
  {
    "VehicleId": "1669",
    "CurrentRoute": "51A",
    "LastPositionLatitude": 37.83527755737305,
    "LastPositionLongitude": -122.2519302368164,
    "DateTimePositionReported": "2026-05-24T16:46:26.7574861-07:00",
    "VehicleCapacity": 47,
    "CurrentPassengerCount": null,
    "EstimatedOccupancyPercentage": null,
    "EstimatedOccupancyStatusColor": "#00b33c",
    "EstimatedOccupancyStatus": "Not Crowded",
    "DateTimeAPCReported": "2026-05-24T16:46:26.7574861-07:00"
  }
]
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
[
  {
    "VehicleId": "1676",
    "CurrentRoute": "51A",
    "LastPositionLatitude": 37.76605224609375,
    "LastPositionLongitude": -122.24343872070312,
    "DateTimePositionReported": "2026-05-24T16:46:26.7424664-07:00",
    "VehicleCapacity": 47,
    "CurrentPassengerCount": null,
    "EstimatedOccupancyPercentage": null,
    "EstimatedOccupancyStatusColor": "#00b33c",
    "EstimatedOccupancyStatus": "Not Crowded",
    "DateTimeAPCReported": "2026-05-24T16:46:26.7424664-07:00"
  }
]
```
# Vehicles — Characteristics and Occupancy

## `GET /vehicle/{vehicleId}`
Real-time location and status for a single vehicle.

**Path params:** `vehicleId` (integer)

**Response:** `{ VehicleId, CurrentTripId, Latitude, Longitude, Heading, TimeLastReported }` — Lat/Lng/Heading/TimeLastReported are nullable. Real-time data only supplied when vehicle is actively servicing a route.

---

## `GET /vehicle/characteristics`
Physical and operational specs for one or all active vehicles.

**Query params:** `vehicleId` (optional — omit to get all active vehicles), `token`

**Response:** `{ VehicleId, IsActive, Description, VehicleType, VehicleTypeDescription, Make, SerialNumber, LicenseNumber, Length, PropulsionType, HasWiFi, HasAC, StandingCapacity, SeatingCapacity, LimitCapacity }`

---

## `GET /vehicle/{vehicleId}/characteristics`
Same as above but single vehicle via path param. Returns single object, not array.

---

## `GET /vehicle/realtimeattributes`
Real-time position and occupancy for one or more vehicles.

**Query params:** `vehicleId` (optional), `routename` (optional), `token`

**Response:** `{ VehicleId, CurrentRoute, LastPositionLatitude, LastPositionLongitude, DateTimePositionReported, VehicleCapacity, CurrentPassengerCount, EstimatedOccupancyPercentage, EstimatedOccupancyStatusColor, EstimatedOccupancyStatus, DateTimeAPCReported }` — all position/occupancy fields are nullable. `EstimatedOccupancyStatus` values: `Not Crowded`, `Some Crowding`, `Crowded`.

---

## `GET /vehicle/{vehicleId}/realtimeattributes`
Real-time attributes for a specific vehicle on a specific route.

**Path params:** `vehicleId`, `routename` (both required in path)

**Response:** Single VehicleRealtimeAttributes object (same fields as above).

---

## `GET /vehicle/route/{routename}/realtimeattributes`
Real-time attributes for all vehicles on a route.

**Path params:** `routename`
**Query params:** `vehicleId` (optional filter), `token`

**Response:** Array of VehicleRealtimeAttributes objects.

---

## `POST /vehicle/realtimeattributes`
Real-time attributes for a batch of vehicle IDs.

**Request body:**
```json
{ "Vehicles": ["string", "string"], "Route": "string" }
```

**Response:** Array of VehicleRealtimeAttributes objects.
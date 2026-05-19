# Stops — Lookup, Proximity Search, Predictions, Profiles

Stop object shape (used across multiple endpoints):
`{ StopId, Name, Latitude, Longitude, City, ScheduledTime }` — date portion of `ScheduledTime` is irrelevant; use only the time component.

---

## `GET /stops`
All currently active AC Transit stops.

**Response:** Array of Stop objects.

---

## `GET /stops/summary`
Stop count and last-updated timestamp.

**Response:** `{ Count, LastUpdatedDateTime }`

---

## `GET /stops/{latitude}/{longitude}/{distance}/{active}/{routeName}`
Proximity search — all parameters in path.

**Path params:**
- `latitude`, `longitude` — search center
- `distance` — radius in feet (default 500, max 25,000)
- `active` — include inactive stops (default false)
- `routeName` — filter to a specific route (optional)

**Response:** Array of Stop objects ordered nearest to farthest.

---

## `GET /stops/{latitude}/{longitude}`
Proximity search — optional params as query string.

**Path params:** `latitude`, `longitude`
**Query params:** `distance`, `active`, `routeName`, `token`

**Response:** Array of Stop objects ordered nearest to farthest.

---

## `GET /stops/{stopId}/predictions`
Arrival/departure predictions for a stop.

> ⚠️ The official docs returned HTTP 500 for this endpoint. Response likely mirrors `/actrealtime/prediction` or returns `{ VehicleId, RouteId, Direction, PredictedMinutes, ScheduledTime }`.

---

## `GET /stops/{stopId}/routes`
All routes serving a specific stop.

**Query params:** `callback` (JSONP), `token`

**Response:** Array of route identifier strings e.g. `["72", "72R", "88"]`

---

## `GET /stops/{stopId}/tripstoday`
All trips that travel to a stop today.

**Query params:** `routes` (comma-delimited filter), `direction` (comma-delimited filter), `token`

**Response:** Array of TripStopToday objects
`{ RouteId, DirectionId, Direction, ScheduleType, Headsign, Destination, Destination2, TripStartTime, TripId, TripNumber, PassingTime, StopId, StopDescription, StopLatitude, StopLongitude }`

---

## `GET /stop/{stopId}/destinations`
All routes and destinations at a stop, including final passing times.

**Response:**
```json
{
  "StopId": 1234,
  "Status": "string",
  "RouteDestinations": [
    { "RouteId": "string", "DirectionId": 1, "Direction": "string",
      "Destination": "string", "FinalPassingTime": "2026-05-18T22:00:00", "Status": "string" }
  ]
}
```

---

## `GET /stop/{stopId}/profile`
Comprehensive stop profile including location, service status, and amenity links.

**Path params:** `stopId` — uses 511's unique stop identifier

**Response:**
`{ StopId, Street, City, SiteDirection, Site, Corner, IsInService, Latitude, Longitude, Routes, AllowAlighting, AllowBoarding, PlaceId, PlaceDescription }`

Plus linked resource objects (each contains a `Url` string):
- `StopServiceAlerts` — link to service alerts
- `Amenities` — link to amenities info
- `Predictions` — link to real-time predictions
- `Map` — link to stop map
- `Schedules` — array of `{ RouteId, Url }` per route
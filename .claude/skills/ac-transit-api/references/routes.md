# Routes

## `GET /routes/{booking}`
All AC Transit routes for a booking period.

**Path params:** `booking` — `Current` (default), `Next`, or a specific BookingId
**Query params:** `sortType` (`Alphabetical`/`0` or `Natural`/`1`, default `Natural`), `token`

**Response:** Array of Route objects
`{ RouteId, Name, Division, Description, IsLocal, IsTransbay, IsRapid, IsAllNighter, IsSchool }`

---

## `GET /route/{routeName}/{booking}`
Single route details. Returns a single Route object (same fields as above).

---

## `GET /route/{routeName}/trips`
All trips for a route.

**Query params:** `direction`, `scheduleType` (`Weekday`|`Saturday`|`Sunday`), `token`

**Response:** Array of `{ TripId, RouteName, ScheduleType, StartTime, Direction }`

---

## `GET /route/{routeName}/tripsinstructions`
Trips with operator driving instructions.

**Query params:** `direction`, `scheduleType` (required), `token`

**Response:** Array of `{ TimePoints, InstructionsText, TripId, RouteName, ScheduleType, StartTime, Direction }`

---

## `GET /route/{routeName}/directions`
All directions serviced by a route.

**Response:** Array of strings e.g. `["Northbound", "Southbound"]`

---

## `GET /route/{routeName}/stops/{booking}`
All stops for a route, organized by direction.

**Query params:** `direction`, `destination`, `scheduleType` (`Today`|`Saturday`|`Sunday`|`Weekday`), `byPattern` (bool), `token`

**Response:**
```json
{ "Route": "string", "Direction": "string", "Destination": "string",
  "Stops": [{ "StopId": 1, "Name": "string", "Latitude": 37.8, "Longitude": -122.2, "Order": 1 }] }
```

---

## `GET /route/{routeName}/trip/{tripId}/pattern`
Ordered geographic waypoints (timepoints) for a specific trip.

**Response:** Array of `{ TripId, Sequence, Latitude, Longitude }`

---

## `GET /route/{routeName}/trip/{tripId}/stops`
All stops with scheduled departure times for a trip.

**Response:** Array of `{ StopId, Name, Latitude, Longitude, City, ScheduledTime }`
> Note: The date portion of `ScheduledTime` is irrelevant; use only the time.

---

## `GET /route/{routeName}/vehicles`
Real-time location of all vehicles currently on a route.

**Response:** Array of `{ VehicleId, CurrentTripId, Latitude, Longitude, Heading, TimeLastReported }` (Lat/Lng/Heading/TimeLastReported are nullable)

---

## `GET /route/{routeName}/tripestimate`
Future trip estimates between two stops on a route.

**Query params:** `fromStopId` (required), `toStopId` (required), `token`
> Both stops must belong to the same route and appear in the correct sequence.

**Response:** Array of `{ RouteName, OriginStopId, DestinationStopId, ExpectedDepartureTime, TripDuration, VehicleId }`

---

## `GET /route/{routes}/waypoints/{booking}`
Full geographic waypoints for one or more routes.

**Path params:** `routes` — comma-delimited or `all`; `booking` — `Current`/`Next`/BookingId
**Query params:** `scheduleType` (`Weekday` default), `token`

---

## `GET /route/{routes}/waypointsfast/{booking}`
Compact (fast) waypoints. Same params as `/waypoints/{booking}` but lighter payload.

---

## `GET /route/{routes}/tripstoday`
Today's trips for specified routes.

**Query params:** `direction`, `destination`, `token`

---

## `GET /route/{routes}/tripstops`
Today's trip stops for specified routes.

**Query params:** `direction`, `destination`, `token`

---

## `GET /route/{routes}/timetable/{direction}`
Timetable for routes in a given direction.

**Query params:** `scheduleType`, `token`

---

## `GET /route/{routes}/schedule/{booking}`
Comprehensive schedule: stops, trips, exceptions, route profiles.

**Query params:** `direction`, `destination`, `dayCode` (`Weekday`|`Saturday`|`Sunday`), `hasAllStops` (bool), `stopId`, `token`

**Response:**
```json
{
  "BookingId": "string",
  "RouteProfiles": [{ "RouteId": "string", "Profile": "string" }],
  "DateExceptions": [{ "RouteId": "string", "ServiceExceptions": [...] }],
  "Stops": [{ "StopId": "string", "PlaceName": "string", "PlaceId": "string",
              "StopDescription": "string", "Longitude": -122.2, "Latitude": 37.8, "City": "string" }],
  "Routes": [{ "RouteId": "string", "LineDirection": "string", "LineDestination": "string",
               "DayCode": ["string"], "OperatingDOW": "string",
               "Trips": [{ "StartTime": "08:00:00", "PatternId": "string", "TripId": ["string"],
                           "Status": "string",
                           "StopTimes": [{ "StopTime": "...", "StopId": "string", "PlaceId": "string", "Occupancy": "string" }] }] }]
}
```

---

## `GET /route/{routeName}/destinations`
All destinations for a route with directional detail.

**Response:** Array of `{ RouteId, DirectionId, Direction, Destination }`

---

## `GET /route/{routes}/exceptions/{booking}`
Service exceptions (cancellations, deviations) for routes.

**Path params:** `routes` — comma-delimited or `ALL`

**Response:** `{ BookingId, DateExceptions: [{ RouteId, ServiceExceptions: [{ ExceptionCode, PatternId, TripId, OperatingDays, ExceptionDates, ExceptionNotices }] }] }`

---

## `GET /route/{routes}/profile`
Profile (description text) for specified routes.

**Path params:** `routes` — comma-delimited or `ALL`

**Response:** Array of `{ RouteId, Profile }`
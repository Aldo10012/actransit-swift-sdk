# Routes — Route Listings, Schedules, Stops, Trips, and Waypoints

---

## `GET /routes/{booking}`

Returns all AC Transit routes for a given booking period.

**Path Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| booking | string | No | Schedule identifier. Use `Current` (or omit) for current, `Next` for upcoming, or a specific BookingId |

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| sortType | string/int | No | Sort order: `Alphabetical`/`0` or `Natural`/`1`. Defaults to `Natural` |
| token | string | Yes | API authentication token |

**Response Body** — Array of Route objects

| Field | Type | Description |
|-------|------|-------------|
| RouteId | string | Unique route identifier |
| Name | string | Public-facing route name |
| Division | string | Assigned operating division |
| Description | string | Additional route details |
| IsLocal | boolean | True if non-Transbay route |
| IsTransbay | boolean | True if Transbay route |
| IsRapid | boolean | True if Rapid service |
| IsAllNighter | boolean | True if all-night service |
| IsSchool | boolean | True if school route |

---

## `GET /route/{routeName}/{booking}`

Returns details for a specific route in a given booking period.

> **Note:** The detail page for this endpoint returns HTTP 500 from the documentation server. Based on other route endpoints, it likely returns a single Route object with the same fields as `/routes/{booking}`.

**Path Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| routeName | string | Yes | Route identifier (e.g., `72`, `NL`) |
| booking | string | No | Schedule identifier: `Current`, `Next`, or a specific BookingId |

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| token | string | Yes | API authentication token |

---

## `GET /route/{routeName}/trips`

Returns all trips for a given route, optionally filtered by direction and schedule type.

**Path Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| routeName | string | Yes | Route identifier |

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| direction | string | No | Filter by direction of travel |
| scheduleType | TripScheduleType | No | `Weekday`, `Saturday`, or `Sunday` |
| token | string | Yes | API authentication token |

**Response Body** — Array of Trip objects

| Field | Type | Description |
|-------|------|-------------|
| TripId | integer | Trip identifier |
| RouteName | string | Route name |
| ScheduleType | integer | 0 = Weekday, etc. |
| StartTime | datetime | ISO 8601 scheduled start time |
| Direction | string | Trip direction |

---

## `GET /route/{routeName}/tripsinstructions`

Returns trips with operator driving instructions for a given route.

**Path Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| routeName | string | Yes | Route identifier |

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| direction | string | No | Filter by direction of travel |
| scheduleType | TripScheduleType | Yes | `Weekday`, `Saturday`, or `Sunday` |
| token | string | Yes | API authentication token |

**Response Body** — Array of TripInstruction objects

| Field | Type | Description |
|-------|------|-------------|
| TimePoints | collection | Driving instructions at each time point |
| InstructionsText | string | Operator driving instructions as plain text |
| TripId | integer | Trip identifier |
| RouteName | string | Route name |
| ScheduleType | TripScheduleType | Schedule type |
| StartTime | datetime | Scheduled start time |
| Direction | string | Trip direction |

---

## `GET /route/{routeName}/directions`

Returns all directions serviced by a given route.

**Path Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| routeName | string | Yes | Route identifier |

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| token | string | Yes | API authentication token |

**Response Body** — Array of strings (direction names)

```json
["Northbound", "Southbound"]
```

---

## `GET /route/{routeName}/stops/{booking}`

Returns all stops for a given route, organized by direction or stop pattern.

**Path Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| routeName | string | Yes | Route identifier |
| booking | string | No | `Current` (default), `Next`, or a specific BookingId |

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| direction | string | No | Filter by direction |
| destination | string | No | Filter by destination; should match actrealtime API values |
| scheduleType | TripScheduleType | No | `Today`, `Saturday`, `Sunday`, or `Weekday` |
| byPattern | boolean | No | If true, return stops per stop pattern; default false |
| token | string | Yes | API authentication token |

**Response Body** — Array of RouteStopOrder objects

```json
{
  "Route": "string",
  "Direction": "string",
  "Destination": "string",
  "Stops": [
    {
      "StopId": 1,
      "Name": "string",
      "Latitude": 37.8,
      "Longitude": -122.2,
      "Order": 1
    }
  ]
}
```

---

## `GET /route/{routeName}/trip/{tripId}/pattern`

Returns the ordered geographic waypoints (timepoints) for a specific trip.

**Path Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| routeName | string | Yes | Route identifier |
| tripId | integer | Yes | Trip identifier |

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| token | string | Yes | API authentication token |

**Response Body** — Array of TimePoint objects

| Field | Type | Description |
|-------|------|-------------|
| TripId | integer | Trip identifier |
| Sequence | integer | Position along the route path |
| Latitude | decimal | Geographic latitude |
| Longitude | decimal | Geographic longitude |

---

## `GET /route/{routeName}/trip/{tripId}/stops`

Returns all stops with scheduled departure times for a specific trip.

**Path Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| routeName | string | Yes | Route identifier |
| tripId | integer | Yes | Trip identifier |

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| token | string | Yes | API authentication token |

**Response Body** — Array of Stop objects

| Field | Type | Description |
|-------|------|-------------|
| StopId | integer | Unique stop identifier |
| Name | string | Stop name |
| Latitude | decimal | Geographic latitude |
| Longitude | decimal | Geographic longitude |
| City | string | City where stop is located |
| ScheduledTime | datetime | Scheduled vehicle departure time (date portion is irrelevant; use only the time) |

---

## `GET /route/{routeName}/vehicles`

Returns real-time location data for all vehicles currently operating on a route.

**Path Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| routeName | string | Yes | Route identifier |

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| token | string | Yes | API authentication token |

**Response Body** — Array of Vehicle objects

| Field | Type | Description |
|-------|------|-------------|
| VehicleId | integer | Vehicle identifier |
| CurrentTripId | integer | Trip currently being serviced |
| Latitude | decimal | Geographic latitude (nullable) |
| Longitude | decimal | Geographic longitude (nullable) |
| Heading | integer | Direction of travel in degrees (nullable) |
| TimeLastReported | datetime | Most recent data timestamp (nullable) |

---

## `GET /route/{routeName}/tripestimate`

Returns all future trip estimates between two stops on a route.

**Path Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| routeName | string | Yes | Route identifier |

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| fromStopId | integer | Yes | Starting stop identifier |
| toStopId | integer | Yes | Destination stop identifier |
| token | string | Yes | API authentication token |

> **Note:** Both stops must belong to the same route and appear in correct sequence; otherwise an error is returned.

**Response Body** — Array of TripEstimate objects

| Field | Type | Description |
|-------|------|-------------|
| RouteName | string | Route name |
| OriginStopId | integer | Starting stop ID |
| DestinationStopId | integer | Destination stop ID |
| ExpectedDepartureTime | datetime | Predicted vehicle arrival at origin |
| TripDuration | timespan | Total journey duration |
| VehicleId | integer | Vehicle servicing the trip |

---

## `GET /route/{routes}/waypoints/{booking}`

Returns full geographic waypoints for one or more routes.

**Path Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| routes | string | Yes | Comma-delimited route identifiers; use `all` for all routes |
| booking | string | No | `Current` (default), `Next`, or a specific BookingId |

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| scheduleType | TripScheduleType | No | `Weekday` (default), `Saturday`, or `Sunday` |
| token | string | Yes | API authentication token |

**Response Body** — Array of RouteWaypoints objects

```json
{
  "Booking": "string",
  "RouteAlpha": "string",
  "Patterns": [
    {
      "DirectionId": 1,
      "Direction": "string",
      "Destination": "string",
      "FirstPlaceId": "string",
      "LastPlaceId": "string",
      "IsDefault": true,
      "TotalDistance": 12345,
      "Waypoints": [
        {
          "OrderID": 1,
          "Latitude": 37.8,
          "Longitude": -122.2,
          "Heading": 180.0,
          "DistanceToNextStop": 500,
          "DistanceFromStart": 0,
          "StopSequence": 1
        }
      ]
    }
  ]
}
```

---

## `GET /route/{routes}/waypointsfast/{booking}`

Returns waypoints optimized for speed. Same top-level structure as `/waypoints/` but `Waypoints` is a compact string array per pattern rather than full objects.

**Path Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| routes | string | Yes | Comma-delimited route identifiers; use `all` for all routes |
| booking | string | No | `Current` (default), `Next`, or a specific BookingId |

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| scheduleType | TripScheduleType | No | `Weekday` (default), `Saturday`, or `Sunday` |
| token | string | Yes | API authentication token |

---

## `GET /route/{routes}/tripstoday`

Returns all scheduled trips operating on specified routes today, with stop-level detail.

**Path Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| routes | string | Yes | Comma-delimited route identifiers |

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| direction | string | No | Filter by direction or destination (comma-delimited) |
| token | string | Yes | API authentication token |

**Response Body** — Array of TripStopToday objects

| Field | Type | Description |
|-------|------|-------------|
| RouteId | string | Route identifier |
| DirectionId | integer | Numeric direction code |
| Direction | string | Cardinal direction string |
| ScheduleType | string | Schedule classification |
| Headsign | string | Sign text shown on vehicle |
| Destination | string | Trip destination |
| TripStartTime | datetime | Scheduled trip start |
| PassingTime | datetime | Scheduled time at this stop |
| TripId | integer | Trip identifier |
| StopId | integer | Stop identifier |
| StopDescription | string | Stop description |
| StopLatitude | decimal | Stop latitude |
| StopLongitude | decimal | Stop longitude |
| PlaceId | string | Place identifier |

---

## `GET /route/{routes}/tripstops`

Returns all stops and trips for specified routes for today. Similar to `/tripstoday` but includes additional internal trip/stop fields.

**Path Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| routes | string | Yes | Comma-delimited route identifiers |

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| direction | string | No | Filter by direction or destination (comma-delimited) |
| token | string | Yes | API authentication token |

**Response Body** — Array of TripStopToday objects (superset of `/tripstoday` fields)

| Additional Fields | Type | Description |
|---|---|---|
| Destination2 | string | Secondary destination |
| TripNumber | integer | Public trip number |
| TripNumber2 | integer | Secondary trip number |
| PositionNumber | integer | Vehicle position number |
| InternalTripNumber | integer | Internal system trip number |
| StopNumber1 | integer | Stop number (format 1) |
| StopNumber2 | string | Stop number (format 2) |

---

## `GET /route/{routes}/timetable/{direction}`

Returns a timetable for specified routes, including all stops and scheduled trip times.

**Path Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| routes | string | Yes | Comma-delimited route identifiers |
| direction | string | No | Direction or destination filter |

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| dayCode | string | No | `Weekday`, `Saturday`, or `Sunday`; defaults to today's day type |
| hasAllStops | boolean | No | If true, show all stops not just major timepoints; default false |
| token | string | Yes | API authentication token |

**Response Body** — Array of TimeTable objects

```json
{
  "BookingId": "string",
  "RouteId": "string",
  "Destination": "string",
  "Direction": "string",
  "DayCode": "string",
  "Stops": [
    { "StopId": 1, "StopDescription": "string", "PlaceId": "string", "StopLongitude": -122.2, "StopLatitude": 37.8 }
  ],
  "Trips": [
    {
      "TripStartTime": "2026-05-18T08:00:00",
      "TripId": 1,
      "TripDestination": "string",
      "TripStops": [
        { "StopId": 1, "PassingTime": "2026-05-18T08:05:00" }
      ]
    }
  ]
}
```

---

## `GET /route/{routes}/schedule/{booking}`

Returns comprehensive schedule data for specified routes, including stops, trips, exceptions, and route profiles.

**Path Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| routes | string | Yes | Comma-delimited route identifiers |
| booking | string | No | `Current` (default), `Next`, or a specific BookingId |

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| direction | string | No | Filter by direction |
| destination | string | No | Filter by destination |
| dayCode | string | No | `Weekday`, `Saturday`, or `Sunday`; defaults to current day |
| hasAllStops | boolean | No | Include all waypoints; default false (returns only stops with a placeID) |
| stopId | string | No | Filter to a specific stop by Id511 code |
| token | string | Yes | API authentication token |

**Response Body**

```json
{
  "BookingId": "string",
  "RouteProfiles": [{ "RouteId": "string", "Profile": "string" }],
  "DateExceptions": [{
    "RouteId": "string",
    "ServiceExceptions": [{
      "ExceptionCode": "string",
      "PatternId": "string",
      "TripId": ["string"],
      "OperatingDays": "string",
      "ExceptionDates": ["string"],
      "ExceptionNotices": ["string"]
    }]
  }],
  "Stops": [{
    "StopId": "string", "PlaceName": "string", "PlaceId": "string",
    "StopDescription": "string", "Longitude": -122.2, "Latitude": 37.8, "City": "string"
  }],
  "Routes": [{
    "RouteId": "string", "LineDirection": "string", "LineDestination": "string",
    "DayCode": ["string"], "OperatingDOW": "string",
    "Trips": [{
      "StartTime": "08:00:00", "PatternId": "string", "TripId": ["string"], "Status": "string",
      "StopTimes": [{ "StopTime": "2026-05-18T08:00:00", "StopId": "string", "PlaceId": "string", "Occupancy": "string" }]
    }]
  }]
}
```

---

## `GET /route/{routeName}/destinations`

Returns all destinations serviced by a given route, with directional detail.

**Path Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| routeName | string | Yes | Route identifier |

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| token | string | Yes | API authentication token |

**Response Body** — Array of RouteDestination objects

| Field | Type | Description |
|-------|------|-------------|
| RouteId | string | Route name |
| DirectionId | integer | Numeric direction code |
| Direction | string | Cardinal direction string |
| Destination | string | Destination string |

---

## `GET /route/{routes}/exceptions/{booking}`

Returns service exceptions (cancellations, deviations, notices) for specified routes.

**Path Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| routes | string | Yes | Comma-delimited route identifiers or `ALL` |
| booking | string | No | `Current` (default), `Next`, or a specific BookingId |

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| token | string | Yes | API authentication token |

**Response Body**

```json
{
  "BookingId": "string",
  "DateExceptions": [{
    "RouteId": "string",
    "ServiceExceptions": [{
      "ExceptionCode": "string",
      "PatternId": "string",
      "TripId": ["string"],
      "OperatingDays": "string",
      "ExceptionDates": ["string"],
      "ExceptionNotices": ["string"]
    }]
  }]
}
```

---

## `GET /route/{routes}/profile`

Returns profile (description) information for specified routes.

**Path Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| routes | string | Yes | Comma-delimited route identifiers or `ALL` |

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| token | string | Yes | API authentication token |

**Response Body** — Array of RouteProfile objects

| Field | Type | Description |
|-------|------|-------------|
| RouteId | string | Route name |
| Profile | string | Route description text |
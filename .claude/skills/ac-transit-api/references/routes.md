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

**Response Sample (JSON):**

```json
[
  {
    "Division": "sample string 1",
    "IsLocal": true,
    "IsTransbay": true,
    "IsAllNighter": true,
    "IsRapid": true,
    "IsSchool": true,
    "RouteId": "sample string 7",
    "Name": "sample string 8",
    "Description": "sample string 9"
  },
  {
    "Division": "sample string 1",
    "IsLocal": true,
    "IsTransbay": true,
    "IsAllNighter": true,
    "IsRapid": true,
    "IsSchool": true,
    "RouteId": "sample string 7",
    "Name": "sample string 8",
    "Description": "sample string 9"
  }
]
```

---

## `GET /route/{routeName}/{booking}`

Returns details for a specific route in a given booking period. Response model is `Route` (3 fields: RouteId, Name, Description) — distinct from the `RouteDivision` model returned by `/routes/{booking}`.

**Path Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| routeName | string | Yes | The route to be retrieved (e.g., `72`, `NL`) |
| booking | string | No | Schedule identifier: `Current`, `Next`, or a specific BookingId |

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| token | string | Yes | API authentication token |

**Response Body** — Single Route object

| Field | Type | Description |
|-------|------|-------------|
| RouteId | string | Route's unique identifier |
| Name | string | The Route's name as seen by the public |
| Description | string | Additional information regarding the route |

**Response Sample (JSON):**

```json
{
    "RouteId": "72",
    "Name": "72",
    "Description": "CCC - San Pablo"
}
```

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
| StartTime | datetime | Scheduled start time; the date portion is always a fixed placeholder (`2000-01-01`) — use only the time component |
| Direction | string | Trip direction |

**Response Sample (JSON):**

```json
[
  {
    "TripId": 1,
    "RouteName": "sample string 2",
    "ScheduleType": 0,
    "StartTime": "2026-05-21T08:22:19.1486563-07:00",
    "Direction": "sample string 4"
  },
  {
    "TripId": 1,
    "RouteName": "sample string 2",
    "ScheduleType": 0,
    "StartTime": "2026-05-21T08:22:19.1486563-07:00",
    "Direction": "sample string 4"
  }
]
```

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
| TimePoints | Collection of TimePointInstruction \| null | Driving instructions at each time point; may be `null` |
| InstructionsText | string | Operator driving instructions as plain text |
| TripId | integer | Trip identifier |
| RouteName | string | Route name |
| ScheduleType | TripScheduleType | Schedule type |
| StartTime | datetime | Scheduled start time |
| Direction | string | Trip direction |

**TimePointInstruction fields:**

| Field | Type | Description |
|-------|------|-------------|
| Instruction | string | Driving instruction text |
| TripId | integer | Trip identifier |
| Sequence | integer | Order along the route path |
| Latitude | decimal | Geographic latitude |
| Longitude | decimal | Geographic longitude |

**Response Sample (JSON):**

```json
[
  {
    "TimePoints": [
      { "Instruction": "sample string 1", "TripId": 2, "Sequence": 3, "Latitude": 1.0, "Longitude": 1.0 }
    ],
    "InstructionsText": "sample string 1",
    "TripId": 2,
    "RouteName": "sample string 3",
    "ScheduleType": 0,
    "StartTime": "2026-05-18T...",
    "Direction": "sample string 5"
  }
]
```

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

**Response Body** — Array of strings. Each direction appears **twice**: first as an abbreviated code, then as the full name.

```json
["NORTH", "Northbound", "SOUTH", "Southbound"]
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

**Response Sample (JSON):**

```json
[
  {
    "TripId": 1,
    "Sequence": 2,
    "Latitude": 1.0,
    "Longitude": 1.0
  },
  {
    "TripId": 1,
    "Sequence": 2,
    "Latitude": 1.0,
    "Longitude": 1.0
  }
]
```

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

**Response Sample (JSON):**

```json
[
  {
    "StopId": 1,
    "Name": "sample string 2",
    "Latitude": 3.0,
    "Longitude": 4.0,
    "City": "sample string 5",
    "ScheduledTime": "2026-05-21T08:22:20.1513063-07:00"
  },
  {
    "StopId": 1,
    "Name": "sample string 2",
    "Latitude": 3.0,
    "Longitude": 4.0,
    "City": "sample string 5",
    "ScheduledTime": "2026-05-21T08:22:20.1513063-07:00"
  }
]
```

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

**Response Sample (JSON):**

```json
[
  {
    "VehicleId": 1,
    "CurrentTripId": 2,
    "Latitude": 1.0,
    "Longitude": 1.0,
    "Heading": 1,
    "TimeLastReported": "2026-05-21T08:22:18.75695-07:00"
  },
  {
    "VehicleId": 1,
    "CurrentTripId": 2,
    "Latitude": 1.0,
    "Longitude": 1.0,
    "Heading": 1,
    "TimeLastReported": "2026-05-21T08:22:18.75695-07:00"
  }
]
```

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

**Response Sample (JSON):**

```json
[
  {
    "RouteName": "sample string 1",
    "OriginStopId": 2,
    "DestinationStopId": 3,
    "ExpectedDepartureTime": "2026-05-21T01:03:49.799401-07:00",
    "TripDuration": "00:00:00.1234567",
    "VehicleId": 1
  },
  {
    "RouteName": "sample string 1",
    "OriginStopId": 2,
    "DestinationStopId": 3,
    "ExpectedDepartureTime": "2026-05-21T01:03:49.799401-07:00",
    "TripDuration": "00:00:00.1234567",
    "VehicleId": 1
  }
]
```

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

**Response Sample (JSON):**

```json
[
  {
    "Booking": "sample string 1",
    "RouteAlpha": "sample string 2",
    "Patterns": [
      {
        "DirectionId": 1,
        "Direction": "sample string 2",
        "Destination": "sample string 3",
        "FirstPlaceId": "sample string 4",
        "LastPlaceId": "sample string 5",
        "IsDefault": true,
        "TotalDistance": 7,
        "Waypoints": [
          "sample string 1",
          "sample string 2"
        ]
      }
    ]
  }
]
```

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
| Destination2 | string | Secondary destination |
| TripStartTime | datetime | Scheduled trip start |
| TripId | integer | Trip identifier |
| TripNumber | integer | Public trip number |
| TripNumber2 | integer | Secondary trip number |
| PositionNumber | integer | Vehicle position number |
| StopId | integer | Stop identifier |
| StopDescription | string | Stop description |
| PassingTime | datetime | Scheduled time at this stop |
| StopNumber1 | integer | Stop number (format 1) |
| StopNumber2 | string | Stop number (format 2) |
| PlaceId | string | Place identifier |
| StopLongitude | decimal | Stop longitude |
| StopLatitude | decimal | Stop latitude |

**Response Sample (JSON):**

```json
[
  {
    "RouteId": "sample string 1",
    "DirectionId": 2,
    "Direction": "sample string 3",
    "ScheduleType": "sample string 4",
    "Headsign": "sample string 5",
    "Destination": "sample string 6",
    "Destination2": "sample string 7",
    "TripStartTime": "2026-05-21T04:12:43.2840424-07:00",
    "TripId": 9,
    "TripNumber": 10,
    "TripNumber2": 11,
    "PositionNumber": 12,
    "StopId": 13,
    "StopDescription": "sample string 14",
    "PassingTime": "2026-05-21T04:12:43.2840424-07:00",
    "StopNumber1": 16,
    "StopNumber2": "sample string 17",
    "PlaceId": "sample string 18",
    "StopLongitude": 19.0,
    "StopLatitude": 20.0
  },
  {
    "RouteId": "sample string 1",
    "DirectionId": 2,
    "Direction": "sample string 3",
    "ScheduleType": "sample string 4",
    "Headsign": "sample string 5",
    "Destination": "sample string 6",
    "Destination2": "sample string 7",
    "TripStartTime": "2026-05-21T04:12:43.2840424-07:00",
    "TripId": 9,
    "TripNumber": 10,
    "TripNumber2": 11,
    "PositionNumber": 12,
    "StopId": 13,
    "StopDescription": "sample string 14",
    "PassingTime": "2026-05-21T04:12:43.2840424-07:00",
    "StopNumber1": 16,
    "StopNumber2": "sample string 17",
    "PlaceId": "sample string 18",
    "StopLongitude": 19.0,
    "StopLatitude": 20.0
  }
]
```

---

## `GET /route/{routes}/tripstops`

Returns all stops and trips for specified routes for today. Returns the same TripStopToday model as `/tripstoday`.

**Path Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| routes | string | Yes | Comma-delimited route identifiers |

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| direction | string | No | Filter by direction or destination (comma-delimited) |
| token | string | Yes | API authentication token |

**Response Body** — Array of TripStopToday objects (same schema as `/tripstoday`)

**Response Sample (JSON):**

```json
[
  {
    "RouteId": "sample string 1",
    "DirectionId": 2,
    "Direction": "sample string 3",
    "ScheduleType": "sample string 4",
    "Headsign": "sample string 5",
    "Destination": "sample string 6",
    "Destination2": "sample string 7",
    "TripStartTime": "2026-05-21T08:22:18.1297581-07:00",
    "TripId": 9,
    "TripNumber": 10,
    "TripNumber2": 11,
    "PositionNumber": 12,
    "StopId": 13,
    "StopDescription": "sample string 14",
    "PassingTime": "2026-05-21T08:22:18.1297581-07:00",
    "StopNumber1": 16,
    "StopNumber2": "sample string 17",
    "PlaceId": "sample string 18",
    "StopLongitude": 19.0,
    "StopLatitude": 20.0
  },
  {
    "RouteId": "sample string 1",
    "DirectionId": 2,
    "Direction": "sample string 3",
    "ScheduleType": "sample string 4",
    "Headsign": "sample string 5",
    "Destination": "sample string 6",
    "Destination2": "sample string 7",
    "TripStartTime": "2026-05-21T08:22:18.1297581-07:00",
    "TripId": 9,
    "TripNumber": 10,
    "TripNumber2": 11,
    "PositionNumber": 12,
    "StopId": 13,
    "StopDescription": "sample string 14",
    "PassingTime": "2026-05-21T08:22:18.1297581-07:00",
    "StopNumber1": 16,
    "StopNumber2": "sample string 17",
    "PlaceId": "sample string 18",
    "StopLongitude": 19.0,
    "StopLatitude": 20.0
  }
]
```

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

**Response Sample (JSON):**

```json
[
  {
    "RouteId": "sample string 1",
    "DirectionId": 2,
    "Direction": "sample string 3",
    "Destination": "sample string 4"
  },
  {
    "RouteId": "sample string 1",
    "DirectionId": 2,
    "Direction": "sample string 3",
    "Destination": "sample string 4"
  }
]
```

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

> **Note:** Returns HTTP 404 (not an empty array) when no exceptions exist for the requested route.

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

**Response Sample (JSON):**

```json
[
  {
    "RouteId": "sample string 1",
    "Profile": "sample string 2"
  },
  {
    "RouteId": "sample string 1",
    "Profile": "sample string 2"
  }
]
```
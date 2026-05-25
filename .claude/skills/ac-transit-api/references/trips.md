# Trips — Cancellation and Exception Data

---

## `GET /trips/canceled`

Returns all revenue trip exceptions matching provided filter criteria.

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| lastIncidentUniqueId | integer | No | Filter by incident unique ID |
| lastOpenDateTime | datetime | No | Filter by incident open date/time |
| tripDateTimeFrom | datetime | No | Trip start date/time range — from |
| tripDateTimeTo | datetime | No | Trip start date/time range — to |
| token | string | Yes | API authentication token |

**Response Body** — Array of TripException objects

| Field | Type | Description |
|-------|------|-------------|
| TripExceptionId | integer | Exception record identifier |
| EventType | string | Type of exception event (e.g. `"Canceled"`) |
| IncidentId | string | Incident identifier |
| IncidentUniqueId | integer | Unique incident identifier |
| OpenDateTime | datetime | When incident was opened |
| IncidentAddDateTime | datetime | When incident was added |
| ScheduleType | string | Schedule classification (e.g. `"Weekday"`, `"Saturday"`, `"Sunday"`) |
| SourceType | string | Source system that logged the exception (e.g. `"Incident"`) |
| TripNumber | integer | Public trip number |
| InternalTripNumber | integer | Internal trip number |
| TripStartTime | datetime | Trip scheduled start time |
| RouteAlpha | string | Route identifier |
| Direction | string | Trip direction |
| PatternId | integer | Pattern identifier |
| BookingId | string | Booking period identifier (e.g. `"2604SP"`) |
| FromId511 | string | 511 origin stop identifier |
| FromStopId | string | Origin stop identifier |
| ToId511 | string | 511 destination stop identifier |
| ToStopId | string | Destination stop identifier |
| FromStopDescription | string | Origin stop description |
| FromStopLatitude | decimal | Origin stop latitude |
| FromStopLongitude | decimal | Origin stop longitude |
| ToStopDescription | string | Destination stop description |
| ToStopLatitude | decimal | Destination stop latitude |
| ToStopLongitude | decimal | Destination stop longitude |
| StopsInOrder | string | Comma-delimited ordered stop ID list |

**Response Sample (JSON):**

```json
[
  {
    "TripExceptionId": 346120,
    "EventType": "Canceled",
    "IncidentId": "SI260522931495",
    "IncidentUniqueId": 201364184,
    "OpenDateTime": "2026-05-21T17:09:13.703",
    "IncidentAddDateTime": "2026-05-21T17:12:25",
    "ScheduleType": "Weekday",
    "SourceType": "Incident",
    "TripNumber": 9212020,
    "InternalTripNumber": 11856497,
    "TripStartTime": "2026-05-21T17:07:00",
    "RouteAlpha": "65",
    "Direction": "Eastbound",
    "PatternId": 135,
    "BookingId": "2604SP",
    "FromId511": "51096",
    "FromStopId": "9902480",
    "ToId511": "53077",
    "ToStopId": "0303000",
    "FromStopDescription": "Allston Way & Shattuck Av",
    "FromStopLatitude": 37.869491,
    "FromStopLongitude": -122.267649,
    "ToStopDescription": "Grizzly Peak Blvd & Senior Av",
    "ToStopLatitude": 37.883035,
    "ToStopLongitude": -122.235678,
    "StopsInOrder": "57501,59432,52105,57512,53215,56320,54357"
  }
]
```

---

## `GET /trips/tripcancellationinfo/{tripNumber}`

Returns cancellation details and adjacent trips for a specific trip.

**Path Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| tripNumber | integer | Yes | Trip identifier |

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| token | string | Yes | API authentication token |

**Response Body**

| Field | Type | Description |
|-------|------|-------------|
| RouteAlpha | string | Route identifier |
| Direction | string | Travel direction |
| BookingId | string | Associated booking reference |
| Canceled | boolean | Cancellation status |
| Reinstated | boolean | Whether trip was restored |
| TripNumber | integer | Trip identifier |
| InternalTripNumber | integer | Internal system reference |
| TripStartTime | datetime | Scheduled departure |
| ScheduleType | string | Schedule classification |
| NextTripNumber | integer | Next trip number |
| NextInternalTripNumber | integer | Next trip internal ID |
| NextTripStartTime | datetime | Next trip departure time |
| NextScheduleType | string | Next trip schedule type |
| PrevTripNumber | integer | Previous trip number |
| PrevInternalTripNumber | integer | Previous trip internal ID |
| PrevTripStartTime | datetime | Previous trip departure time |
| PrevScheduleType | string | Previous trip schedule type |

**Response Sample (JSON):**

```json
{
  "RouteAlpha": "sample string 1",
  "Direction": "sample string 2",
  "BookingId": "sample string 3",
  "Canceled": true,
  "Reinstated": true,
  "TripNumber": 1,
  "InternalTripNumber": 1,
  "TripStartTime": "2026-05-21T18:00:13.5769221-07:00",
  "ScheduleType": "sample string 4",
  "NextTripNumber": 1,
  "NextInternalTripNumber": 1,
  "NextTripStartTime": "2026-05-21T18:00:13.5769221-07:00",
  "NextScheduleType": "sample string 5",
  "PrevTripNumber": 1,
  "PrevInternalTripNumber": 1,
  "PrevTripStartTime": "2026-05-21T18:00:13.5769221-07:00",
  "PrevScheduleType": "sample string 6"
}
```
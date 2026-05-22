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
| EventType | string | Type of exception event |
| IncidentId | string | Incident identifier |
| IncidentUniqueId | integer | Unique incident identifier |
| OpenDateTime | datetime | When incident was opened |
| IncidentAddDateTime | datetime | When incident was added |
| TripStartTime | datetime | Trip scheduled start time |
| RouteAlpha | string | Route identifier |
| Direction | string | Trip direction |
| TripNumber | integer | Public trip number |
| InternalTripNumber | integer | Internal trip number |
| PatternId | integer | Pattern identifier |
| FromStopId | string | Origin stop identifier |
| ToStopId | string | Destination stop identifier |
| FromStopDescription | string | Origin stop description |
| ToStopDescription | string | Destination stop description |
| FromStopLatitude | decimal | Origin stop latitude |
| FromStopLongitude | decimal | Origin stop longitude |
| ToStopLatitude | decimal | Destination stop latitude |
| ToStopLongitude | decimal | Destination stop longitude |
| StopsInOrder | string | Ordered stop list |

**Response Sample (JSON):**

```json
[
  {
    "TripExceptionId": 1,
    "EventType": "sample string 2",
    "IncidentId": "sample string 3",
    "IncidentUniqueId": 4,
    "OpenDateTime": "2026-05-21T17:57:14.8531098-07:00",
    "IncidentAddDateTime": "2026-05-21T17:57:14.8531098-07:00",
    "ScheduleType": "sample string 5",
    "SourceType": "sample string 6",
    "TripNumber": 1,
    "InternalTripNumber": 1,
    "TripStartTime": "2026-05-21T17:57:14.8531098-07:00",
    "RouteAlpha": "sample string 7",
    "Direction": "sample string 8",
    "PatternId": 1,
    "BookingId": "sample string 9",
    "FromId511": "sample string 10",
    "FromStopId": "sample string 11",
    "ToId511": "sample string 12",
    "ToStopId": "sample string 13",
    "FromStopDescription": "sample string 14",
    "FromStopLatitude": 1.0,
    "FromStopLongitude": 1.0,
    "ToStopDescription": "sample string 15",
    "ToStopLatitude": 1.0,
    "ToStopLongitude": 1.0,
    "StopsInOrder": "sample string 16"
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
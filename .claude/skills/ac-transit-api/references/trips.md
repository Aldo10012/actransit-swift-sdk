# Trips — Cancellations and Exceptions

## `GET /trips/canceled`
All revenue trip exceptions matching filter criteria.

**Query params:** `lastIncidentUniqueId`, `lastOpenDateTime`, `tripDateTimeFrom`, `tripDateTimeTo`, `token`

**Response:** Array of TripException objects
`{ TripExceptionId, EventType, IncidentId, IncidentUniqueId, OpenDateTime, IncidentAddDateTime, TripStartTime, RouteAlpha, Direction, TripNumber, InternalTripNumber, PatternId, FromStopId, ToStopId, FromStopDescription, ToStopDescription, FromStopLatitude, FromStopLongitude, ToStopLatitude, ToStopLongitude, StopsInOrder }`

---

## `GET /trips/tripcancellationinfo/{tripNumber}`
Cancellation details and adjacent trips for a specific trip.

**Path params:** `tripNumber` (integer)

**Response:**
`{ RouteAlpha, Direction, BookingId, Canceled, Reinstated, TripNumber, InternalTripNumber, TripStartTime, ScheduleType, NextTripNumber, NextInternalTripNumber, NextTripStartTime, NextScheduleType, PrevTripNumber, PrevInternalTripNumber, PrevTripStartTime, PrevScheduleType }`
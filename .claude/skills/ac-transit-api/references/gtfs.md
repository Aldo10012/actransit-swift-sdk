# Gtfs — Static Schedule File Management

## `GET /gtfs`
Returns metadata about the currently active GTFS schedule.

**Response:** `{ UpdatedDate, EarliestServiceDate, LatestServiceDate }`

---

## `GET /gtfs/all`
Returns schedule metadata for all bookings (current, past, future).

**Response:** Array of `{ BookingId, UpdatedDate, EarliestServiceDate, LatestServiceDate }`

---

## `GET /gtfs/current`
Downloads current schedule as a GTFS ZIP archive.

**Response:** Binary ZIP (`HttpResponseMessage`)

---

## `GET /gtfs/download`
Alias for `/gtfs/current`. Functionally identical.

---

## `GET /gtfs/next`
Downloads the next upcoming GTFS schedule as a ZIP, when available.

---

## `GET /gtfs/{bookingId}`
Downloads GTFS schedule for a specific booking period.

**Path params:**
- `bookingId` — format `YYMMSeason` (e.g. `26SPSU`). Season codes: `SU`, `FA`, `WR`, `SP`
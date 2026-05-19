# Gtfs — Static Schedule File Management

---

## `GET /gtfs`

Returns metadata about the currently active GTFS schedule.

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| token | string | Yes | API authentication token |

**Response Body**

```json
{
  "UpdatedDate": "2026-05-18T15:20:54.187Z",
  "EarliestServiceDate": "2026-05-18T15:20:54.187Z",
  "LatestServiceDate": "2026-05-18T15:20:54.187Z"
}
```

| Field | Type | Description |
|-------|------|-------------|
| UpdatedDate | datetime | When the GTFS schedule data was last refreshed |
| EarliestServiceDate | datetime | First date covered by the current schedule |
| LatestServiceDate | datetime | Last date covered by the current schedule |

---

## `GET /gtfs/all`

Returns schedule metadata for all bookings (current, past, and future).

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| token | string | Yes | API authentication token |

**Response Body** — `[GtfsInfo]` — Array of schedule objects

```json
[
  {
    "BookingId": "sample string 1",
    "UpdatedDate": "2026-05-18T16:48:54.3989122-07:00",
    "EarliestServiceDate": "2026-05-18T16:48:54.3989122-07:00",
    "LatestServiceDate": "2026-05-18T16:48:54.3989122-07:00"
  }
]
```

| Field | Type | Description |
|-------|------|-------------|
| BookingId | string | Booking identifier |
| UpdatedDate | datetime | Date the GTFS data was last updated |
| EarliestServiceDate | datetime | First date serviced by this schedule |
| LatestServiceDate | datetime | Last date serviced by this schedule |

---

## `GET /gtfs/current`

Downloads the current schedule as a compressed GTFS ZIP archive.

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| token | string | Yes | API authentication token |

**Response** — Binary ZIP file (`HttpResponseMessage`). Parse the `Content` field as a GTFS ZIP archive.

---

## `GET /gtfs/download`

Downloads the current schedule as a compressed GTFS ZIP archive. Functionally equivalent to `/gtfs/current`.

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| token | string | Yes | API authentication token |

**Response** — Binary ZIP file (`HttpResponseMessage`).

---

## `GET /gtfs/next`

Downloads the next upcoming GTFS schedule as a ZIP archive, when available.

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| token | string | Yes | API authentication token |

**Response** — Binary ZIP file (`HttpResponseMessage`). Data availability is conditional on whether a future schedule has been published.

---

## `GET /gtfs/{bookingId}`

Downloads the GTFS schedule for a specific booking period.

**Path Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| bookingId | string | Yes | Booking identifier using format `YYMMSeason` (e.g., `26SPSU`). Season keywords: `SU`, `FA`, `WR`, `SP` |

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| token | string | Yes | API authentication token |

**Response** — Binary ZIP file containing GTFS schedule data for the specified booking.
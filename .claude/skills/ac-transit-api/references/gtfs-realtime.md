# GtfsRealTime — GTFS-RT Feeds (Protocol Buffer)

> **All three endpoints return binary Protocol Buffer data, not JSON.**
> Use a GTFS-RT parser library to decode responses.

---

## `GET /gtfsrt/tripupdates`

Returns the GTFS-Realtime trip updates feed, serialized in Protocol Buffer format.

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| token | string | Yes | API authentication token |

**Response** — `HttpResponseMessage` containing Protocol Buffer binary data (GTFS-RT TripUpdates feed entity).

---

## `GET /gtfsrt/alerts`

Returns the GTFS-Realtime service alerts feed, serialized in Protocol Buffer format.

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| token | string | Yes | API authentication token |

**Response** — `HttpResponseMessage` containing Protocol Buffer binary data (GTFS-RT Alerts feed entity).

---

## `GET /gtfsrt/vehicles`

Returns the GTFS-Realtime vehicle positions feed, serialized in Protocol Buffer format.

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| token | string | Yes | API authentication token |

**Response** — `HttpResponseMessage` containing Protocol Buffer binary data (GTFS-RT VehiclePositions feed entity).
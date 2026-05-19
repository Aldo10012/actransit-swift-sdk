# Stops — Lookup, Proximity Search, Predictions, and Profiles

---

## `GET /stops`

Returns all currently active AC Transit stops.

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
| City | string | City name |
| ScheduledTime | datetime | Scheduled departure time (date portion is irrelevant; use only the time component) |

---

## `GET /stops/summary`

Returns a summary count and last-updated timestamp for active stops.

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| token | string | Yes | API authentication token |

**Response Body**

| Field | Type | Description |
|-------|------|-------------|
| Count | integer | Number of stops in the current list |
| LastUpdatedDateTime | datetime | Last date/time stop information was changed |

---

## `GET /stops/{latitude}/{longitude}/{distance}/{active}/{routeName}`

Returns stops within a radius of the given coordinates (all parameters in path).

**Path Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| latitude | decimal | Yes | Search center latitude |
| longitude | decimal | Yes | Search center longitude |
| distance | decimal | No | Search radius in feet; default 500, max 25,000 |
| active | boolean | No | Include inactive stops; default false |
| routeName | string | No | Filter to a specific route |

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| token | string | Yes | API authentication token |

**Response Body** — Array of Stop objects (same fields as `GET /stops`), ordered by distance from search point nearest to farthest.

---

## `GET /stops/{latitude}/{longitude}`

Returns stops within a radius of the given coordinates (optional params as query string).

**Path Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| latitude | decimal | Yes | Search center latitude |
| longitude | decimal | Yes | Search center longitude |

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| distance | decimal | No | Search radius in feet; default 500, max 25,000 |
| active | boolean | No | Include inactive stops; default false |
| routeName | string | No | Filter to a specific route |
| token | string | Yes | API authentication token |

**Response Body** — Array of Stop objects (same fields as `GET /stops`), ordered by distance nearest to farthest.

---

## `GET /stops/{stopId}/predictions`

Returns arrival/departure predictions for a given stop.

> **Note:** The live documentation page for this endpoint returns HTTP 500. The endpoint exists in the API index but its detail page is inaccessible. Based on other prediction endpoints, the response likely mirrors `/actrealtime/prediction` or returns simplified prediction objects.

**Path Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| stopId | integer | Yes | Stop identifier |

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| token | string | Yes | API authentication token |

---

## `GET /stops/{stopId}/routes`

Returns all transit routes that serve a specific stop.

> **Note:** The live API index describes this endpoint as "Retrieve vehicle predictions for a particular stop" — this appears to be a documentation error. The endpoint name, parameter description ("The stop whose intersecting routes should be retrieved"), and response (array of route ID strings) all confirm it returns routes, not predictions.

**Path Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| stopId | integer | Yes | Stop identifier |

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| callback | string | No | JSONP callback function name |
| token | string | Yes | API authentication token |

**Response Body** — Array of strings (route identifiers)

```json
["72", "72R", "88"]
```

---

## `GET /stops/{stopId}/tripstoday`

Returns all trips that travel to a given stop today.

**Path Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| stopId | integer | Yes | Stop identifier |

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| routes | string | No | Filter by comma-delimited route list |
| direction | string | No | Filter by comma-delimited direction/destination list |
| token | string | Yes | API authentication token |

**Response Body** — Array of TripStopToday objects

| Field | Type | Description |
|-------|------|-------------|
| RouteId | string | Route identifier |
| DirectionId | integer | Numeric direction code |
| Direction | string | Direction string |
| ScheduleType | string | Schedule classification |
| Headsign | string | Vehicle sign text |
| Destination | string | Trip destination |
| Destination2 | string | Secondary destination |
| TripStartTime | datetime | Scheduled trip start |
| TripId | integer | Trip identifier |
| TripNumber | integer | Public trip number |
| TripNumber2 | integer | Secondary trip number |
| PositionNumber | integer | Vehicle position number |
| StopId | integer | Stop identifier |
| StopDescription | string | Stop description |
| PassingTime | datetime | Scheduled passing time at this stop |
| StopNumber1 | integer | Stop number (format 1) |
| StopNumber2 | string | Stop number (format 2) |
| PlaceId | string | Place identifier |
| StopLongitude | decimal | Stop longitude |
| StopLatitude | decimal | Stop latitude |

---

## `GET /stop/{stopId}/destinations`

Returns all routes and destinations available at a given stop, including final passing times.

**Path Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| stopId | integer | Yes | Stop identifier |

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| token | string | Yes | API authentication token |

**Response Body**

```json
{
  "StopId": 1234,
  "Status": "string",
  "RouteDestinations": [
    {
      "RouteId": "string",
      "DirectionId": 1,
      "Direction": "string",
      "Destination": "string",
      "FinalPassingTime": "2026-05-18T22:00:00",
      "Status": "string"
    }
  ]
}
```

---

## `GET /stop/{stopId}/profile`

Returns comprehensive profile information for a stop, including location, service status, amenities links, and schedule URLs.

**Path Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| stopId | integer | Yes | 511's unique stop identifier |

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| token | string | Yes | API authentication token |

**Response Body**

| Field | Type | Description |
|-------|------|-------------|
| StopId | integer | Stop identifier |
| Street | string | Street address |
| City | string | City name |
| SiteDirection | string | Directional placement (e.g., NW corner) |
| Site | string | Site description |
| Corner | string | Corner description |
| IsInService | boolean | Whether stop is currently in service |
| Latitude | decimal | Geographic latitude |
| Longitude | decimal | Geographic longitude |
| Routes | string | Comma-delimited list of routes |
| AllowAlighting | boolean | Passengers may exit here |
| AllowBoarding | boolean | Passengers may board here |
| PlaceId | string | Place identifier |
| PlaceDescription | string | Place description |
| StopServiceAlerts | object | `{ "Url": "string" }` — link to service alerts |
| Amenities | object | `{ "Url": "string" }` — link to amenities info |
| Predictions | object | `{ "Url": "string" }` — link to real-time predictions |
| Map | object | `{ "Url": "string" }` — link to stop map |
| Schedules | array | `[{ "RouteId": "string", "Url": "string" }]` — schedule links per route |
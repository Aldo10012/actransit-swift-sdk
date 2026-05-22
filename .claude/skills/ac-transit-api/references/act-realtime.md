# ActRealtime — BusTime® Real-Time Endpoints

All responses use a `bustime-response` envelope and support optional JSONP via the `callback` query parameter.

```json
{ "bustime-response": { "<data_key>": [...], "error": [{ "msg": "string", ... }] } }
```

---

## `GET /actrealtime/detour`

Returns active detours affecting transit service.

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| rt | string | No | Single route designator (e.g., `20`, `NL`) |
| rtdir | string | No | Route direction; requires `rt`. Must match a direction ID from the directions endpoint |
| callback | string | No | JSONP callback function name |
| token | string | Yes | API authentication token |

**Response Body**

```json
{
  "bustime-response": {
    "dtrs": [
      {
        "id": "string",
        "ver": "string",
        "st": "string",
        "desc": "string",
        "rtdirs": [{ "rt": "string", "dir": "string" }],
        "startdt": "string",
        "enddt": "string"
      }
    ],
    "error": [{ "msg": "string", "rt": "string", "vid": "string" }]
  }
}
```

| Field | Type | Description |
|-------|------|-------------|
| dtrs[].id | string | Detour identifier |
| dtrs[].ver | string | Version |
| dtrs[].st | string | Status |
| dtrs[].desc | string | Description of the detour |
| dtrs[].rtdirs | array | Affected route/direction pairs |
| dtrs[].startdt | string | Start date/time |
| dtrs[].enddt | string | End date/time |

---

## `GET /actrealtime/direction`

Returns the set of directions serviced by a specified route.

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| rt | string | Yes | Single route designator |
| callback | string | No | JSONP callback function name |
| token | string | Yes | API authentication token |

**Response Body**

```json
{
  "bustime-response": {
    "directions": [{ "id": "string", "name": "string" }],
    "error": [{ "rtpidatafeed": "string", "stpid": "string", "rt": "string", "vid": "string", "msg": "string" }]
  }
}
```

---

## `GET /actrealtime/line`

Returns the set of all routes serviced by the system.

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| callback | string | No | JSONP callback function name |
| token | string | Yes | API authentication token |

**Response Body**

```json
{
  "bustime-response": {
    "routes": [
      {
        "rt": "string",
        "rtnm": "string",
        "rtclr": "string",
        "rtdd": "string",
        "rtpidatafeed": "string"
      }
    ],
    "error": [{ "rtpidatafeed": "string", "stpid": "string", "rt": "string", "vid": "string", "msg": "string" }]
  }
}
```

| Field | Type | Description |
|-------|------|-------------|
| rt | string | Route ID |
| rtnm | string | Route name |
| rtclr | string | Route color (hex) |
| rtdd | string | Route description |
| rtpidatafeed | string | Data feed identifier |

---

## `GET /actrealtime/locale`

Returns available language locales for the BusTime system.

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| callback | string | No | JSONP callback function name |
| token | string | Yes | API authentication token |

**Response Body**

```json
{
  "bustime-response": {
    "locale": [{ "localestring": "string", "displayname": "string" }],
    "error": [{ "rtpidatafeed": "string", "stpid": "string", "rt": "string", "vid": "string", "msg": "string" }]
  }
}
```

> When called without a locale parameter, returns all supported language codes. Can be called again with a specific locale to render names in that language. Unsupported locales fall back to the system default.

---

## `GET /actrealtime/pattern`

Returns geo-positional points and stops describing route pattern layouts.

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| pid | string | Conditional | Comma-delimited list of pattern IDs (max 10); mutually exclusive with `rt` |
| rt | string | Conditional | Single route identifier to return all active patterns; mutually exclusive with `pid` |
| callback | string | No | JSONP callback function name |
| token | string | Yes | API authentication token |

> Either `pid` or `rt` must be specified, but not both.

**Response Body**

```json
{
  "bustime-response": {
    "ptr": [
      {
        "pid": 1,
        "ln": 5000,
        "rtdir": "string",
        "pt": [
          { "seq": 1, "typ": "string", "stpid": "string", "stpnm": "string", "pdist": 0, "lat": 37.8, "lon": -122.2 }
        ],
        "dtrid": "string",
        "dtrpt": []
      }
    ],
    "error": [{ "rtpidatafeed": "string", "stpid": "string", "rt": "string", "vid": "string", "msg": "string" }]
  }
}
```

| Field | Type | Description |
|-------|------|-------------|
| ptr[].pid | integer | Pattern ID |
| ptr[].ln | integer | Pattern length |
| ptr[].rtdir | string | Route direction |
| ptr[].pt[].seq | integer | Point sequence number |
| ptr[].pt[].typ | string | Point type |
| ptr[].pt[].stpid | string | Stop ID (if a stop) |
| ptr[].pt[].stpnm | string | Stop name (if a stop) |
| ptr[].pt[].pdist | decimal | Distance from pattern start |
| ptr[].pt[].lat | decimal | Latitude |
| ptr[].pt[].lon | decimal | Longitude |

---

## `GET /actrealtime/prediction`

Returns real-time arrival/departure predictions for stops or vehicles.

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| stpid | string | Conditional | Comma-delimited stop IDs (max 10); mutually exclusive with `vid` |
| rt | string | No | Comma-delimited route designators to filter results |
| vid | string | Conditional | Comma-delimited vehicle IDs (max 10); mutually exclusive with `stpid` |
| top | integer | No | Maximum number of predictions to return; omit for all |
| tmres | string | No | Time resolution: `s` (seconds) or `m` (minutes); default `m` |
| showocprd | boolean | No | Whether to show occupancy prediction data |
| callback | string | No | JSONP callback function name |
| token | string | Yes | API authentication token |

> Either `stpid` or `vid` must be specified, but not both. Results are sorted by predicted arrival time ascending.

**Response Body**

```json
{
  "bustime-response": {
    "prd": [
      {
        "tmstmp": "string",
        "typ": "string",
        "stpnm": "string",
        "stpid": "string",
        "vid": "string",
        "dstp": 1234,
        "rt": "string",
        "rtdir": "string",
        "des": "string",
        "prdtm": "string",
        "dly": false,
        "prdctdn": "string",
        "zone": "string",
        "seq": 1
      }
    ],
    "error": [{ "stpid": "string", "rt": "string", "vid": "string", "msg": "string" }]
  }
}
```

| Field | Type | Description |
|-------|------|-------------|
| tmstmp | string | Timestamp of the prediction |
| typ | string | Prediction type: `A` = arrival, `D` = departure |
| stpnm | string | Stop name |
| stpid | string | Stop ID |
| vid | string | Vehicle ID |
| dstp | number | Distance to stop (feet) |
| rt | string | Route |
| rtdir | string | Route direction |
| des | string | Destination |
| prdtm | string | Predicted time |
| dly | boolean | Whether vehicle is delayed |
| prdctdn | string | Countdown to predicted time |
| zone | string | Zone identifier |
| seq | number | Stop sequence |

---

## `GET /actrealtime/time`

Returns the current BusTime system date and time, for client synchronization.

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| unixTime | boolean | No | If true, returns milliseconds elapsed since Unix epoch (UTC, 1 Jan 1970) |
| callback | string | No | JSONP callback function name |
| token | string | Yes | API authentication token |

**Response Body**

```json
{
  "bustime-response": {
    "tm": {},
    "error": [{ "rtpidatafeed": "string", "stpid": "string", "rt": "string", "vid": "string", "msg": "string" }]
  }
}
```

> The `tm` field contains the system timestamp; its exact sub-fields depend on the `unixTime` flag.

---

## `GET /actrealtime/servicebulletin`

Returns active service bulletins for specified routes or stops.

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| rt | string | Conditional | Comma-delimited route designators (required if `stpid` not provided) |
| rtdir | string | No | Single route direction |
| stpid | string | Conditional | Comma-delimited stop IDs (required if `rt` not provided) |
| callback | string | No | JSONP callback function name |
| token | string | Yes | API authentication token |

> At least one of `rt` or `stpid` must be specified.

**Response Body**

```json
{
  "bustime-response": {
    "sb": [
      {
        "nm": "string",
        "sbj": "string",
        "dtl": "string",
        "brf": "string",
        "cse": "string",
        "efct": "string",
        "prty": "string",
        "rtpidatafeed": "string",
        "mod": "string",
        "srvc": [{ "rt": "string", "rtdir": "string", "stpid": "string", "stpnm": "string" }]
      }
    ],
    "error": [{ "msg": "string", "rt": "string", "stpid": "string", "rtpidatafeed": "string", "vid": "string" }]
  }
}
```

| Field | Type | Description |
|-------|------|-------------|
| nm | string | Bulletin name |
| sbj | string | Subject |
| dtl | string | Detail text |
| brf | string | Brief description |
| cse | string | Cause |
| efct | string | Effect |
| prty | string | Priority |
| mod | string | Last modification timestamp |
| srvc | array | Affected routes/stops |

---

## `GET /actrealtime/stop`

Returns stops for a route/direction pair, or looks up stops by ID.

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| rt | string | Conditional | Single route designator (required with `dir` if `stpid` not provided) |
| dir | string | Conditional | Single route direction (required with `rt` if `stpid` not provided) |
| stpid | string | Conditional | Comma-delimited stop IDs (up to 10); mutually exclusive with `rt`/`dir` |
| callback | string | No | JSONP callback function name |
| token | string | Yes | API authentication token |

> Must provide either (`rt` + `dir`) or `stpid`.

**Response Body**

```json
{
  "bustime-response": {
    "stops": [
      {
        "stpid": "string",
        "stpnm": "string",
        "lat": 37.8,
        "lon": -122.2,
        "dtradd": ["string"],
        "dtrrem": ["string"]
      }
    ],
    "error": [{ "rtpidatafeed": "string", "stpid": "string", "rt": "string", "vid": "string", "msg": "string" }]
  }
}
```

---

## `GET /actrealtime/allstops`

Returns all stops, optionally filtered to a single route, with optional field limiting.

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| rt | string | No | Single route designator; omit to return stops across all routes |
| limitFields | boolean | No | If true, return only `stpid` and `stpnm`; default false |
| callback | string | No | JSONP callback function name |
| token | string | Yes | API authentication token |

**Response Body** — Same structure as `/actrealtime/stop` (array of stop objects inside `bustime-response.stops`).

**Response Sample (JSON):**

```json
{
  "bustime-response": {
    "stops": [
      {
        "stpid": "sample string 1",
        "stpnm": "sample string 2",
        "lat": 3.0,
        "lon": 4.0,
        "dtradd": [
          "sample string 1",
          "sample string 2"
        ],
        "dtrrem": [
          "sample string 1",
          "sample string 2"
        ]
      },
      {
        "stpid": "sample string 1",
        "stpnm": "sample string 2",
        "lat": 3.0,
        "lon": 4.0,
        "dtradd": [
          "sample string 1",
          "sample string 2"
        ],
        "dtrrem": [
          "sample string 1",
          "sample string 2"
        ]
      }
    ],
    "error": [
      {
        "rtpidatafeed": "sample string 1",
        "stpid": "sample string 2",
        "rt": "sample string 3",
        "vid": "sample string 4",
        "msg": "sample string 5"
      }
    ]
  }
}
```

---

## `GET /actrealtime/vehicle`

Returns real-time vehicle location and tracking data, with optional geographic filtering.

**Query Parameters**

| Name | Type | Required | Description |
|------|------|----------|-------------|
| vid | string | Conditional | Comma-delimited vehicle IDs; mutually exclusive with `rt` |
| rt | string | Conditional | Comma-delimited route designators; mutually exclusive with `vid` |
| tmres | string | No | Time resolution: `s` or `m` (default `m`). Timestamp format: `YYYYMMDD HH:MM:SS` or `YYYYMMDD HH:MM` |
| callback | string | No | JSONP callback function name |
| lat | decimal | No | Latitude for geographic radius filtering |
| lng | decimal | No | Longitude for geographic radius filtering |
| searchRadius | decimal | No | Search distance in feet from lat/lng |
| token | string | Yes | API authentication token |

**Response** — `HttpResponseMessage` (parse `bustime-response` envelope; vehicle object fields mirror other actrealtime vehicle responses).
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
        "id": "2738D8B2-F31A-479E-A3E6-EF602C44C845",
        "ver": 4,
        "st": 1,
        "desc": "O WB",
        "rtdirs": [{ "rt": "O", "dir": "To San Francisco" }],
        "startdt": "20260518 00:00",
        "enddt": "20261026 23:59",
        "rtpidatafeed": "bustime"
      }
    ],
    "error": [{ "msg": "string", "rt": "string", "vid": "string" }]
  }
}
```

| Field | Type | Description |
|-------|------|-------------|
| dtrs[].id | string | Detour identifier |
| dtrs[].ver | integer | Version number |
| dtrs[].st | integer | Status code |
| dtrs[].desc | string | Description of the detour |
| dtrs[].rtdirs | array | Affected route/direction pairs |
| dtrs[].startdt | string | Start date/time (`YYYYMMDD HH:MM`) |
| dtrs[].enddt | string | End date/time (`YYYYMMDD HH:MM`) |
| dtrs[].rtpidatafeed | string | Data feed identifier (e.g. `"bustime"`) |

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
        "pid": 8260,
        "ln": 48679.0,
        "rtdir": "To Fruitvale BART",
        "pt": [
          { "seq": 1, "typ": "S", "stpid": "54327", "stpnm": "College Av & Miles Av", "pdist": 0.0, "lat": 37.844542, "lon": -122.251966 },
          { "seq": 2, "typ": "W", "pdist": 0.0, "lat": 37.844378, "lon": -122.251873 }
        ],
        "dtrid": "string",
        "dtrpt": []
      }
    ],
    "error": [{ "rtpidatafeed": "string", "stpid": "string", "rt": "string", "vid": "string", "msg": "string" }]
  }
}
```

> `dtrid` and `dtrpt` are only present when a detour affects the pattern.

| Field | Type | Description |
|-------|------|-------------|
| ptr[].pid | integer | Pattern ID |
| ptr[].ln | decimal | Pattern length (feet) |
| ptr[].rtdir | string | Route direction |
| ptr[].pt[].seq | integer | Point sequence number |
| ptr[].pt[].typ | string | Point type: `S` = stop, `W` = waypoint |
| ptr[].pt[].stpid | string | Stop ID — only present when `typ` is `S` |
| ptr[].pt[].stpnm | string | Stop name — only present when `typ` is `S` |
| ptr[].pt[].pdist | decimal | Distance from pattern start |
| ptr[].pt[].lat | decimal | Latitude |
| ptr[].pt[].lon | decimal | Longitude |
| ptr[].dtrid | string | Detour ID affecting this pattern (optional) |
| ptr[].dtrpt | array | Detour points (optional) |

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
        "tmstmp": "20260524 16:32",
        "typ": "A",
        "stpnm": "Broadway & 12th St (12th St BART)",
        "stpid": "50212",
        "vid": "8004",
        "dstp": 10567,
        "rt": "51A",
        "rtdd": "51A",
        "rtdir": "To Fruitvale BART",
        "des": "Fruitvale BART",
        "prdtm": "20260524 16:47",
        "tablockid": "51009",
        "tatripid": "10551560",
        "origtatripno": "11868504",
        "dly": false,
        "dyn": 0,
        "prdctdn": "14",
        "zone": "",
        "rid": "5107",
        "tripid": "6057010",
        "tripdyn": 0,
        "schdtm": "20260524 16:44",
        "geoid": "2476",
        "seq": 17,
        "psgld": "EMPTY",
        "stst": 59100,
        "stsd": "2026-05-24",
        "flagstop": 0
      }
    ],
    "error": [{ "stpid": "string", "rt": "string", "vid": "string", "msg": "string" }]
  }
}
```

| Field | Type | Description |
|-------|------|-------------|
| tmstmp | string | Timestamp of the prediction (`YYYYMMDD HH:MM` or `HH:MM:SS`) |
| typ | string | Prediction type: `A` = arrival, `D` = departure |
| stpnm | string | Stop name |
| stpid | string | Stop ID |
| vid | string | Vehicle ID |
| dstp | number | Distance to stop (feet) |
| rt | string | Route designator |
| rtdd | string | Route display designation |
| rtdir | string | Route direction |
| des | string | Destination |
| prdtm | string | Predicted arrival/departure time |
| tablockid | string | Tablet/block ID |
| tatripid | string | TA trip ID |
| origtatripno | string | Original TA trip number |
| dly | boolean | Whether vehicle is delayed |
| dyn | integer | Dynamic flag (`0` = static) |
| prdctdn | string | Countdown string to predicted time |
| zone | string | Zone identifier |
| rid | string | Internal route ID |
| tripid | string | Trip ID |
| tripdyn | integer | Trip dynamic flag |
| schdtm | string | Scheduled time |
| geoid | string | Stop geo ID |
| seq | number | Stop sequence number |
| psgld | string | Passenger load: `EMPTY`, `HALF_EMPTY`, `FULL`, etc. |
| stst | integer | Scheduled start time (seconds past midnight) |
| stsd | string | Service date (`YYYY-MM-DD`) |
| flagstop | integer | Flag stop indicator (`0` = not a flag stop) |

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

Default (`unixTime` omitted or `false`):
```json
{ "bustime-response": { "tm": "20260524 16:32:09" } }
```

With `unixTime=true`:
```json
{ "bustime-response": { "tm": "1779665530061" } }
```

> `tm` is always a **string**. Without `unixTime`, format is `YYYYMMDD HH:MM:SS`. With `unixTime=true`, it is milliseconds since the Unix epoch as a numeric string.

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
        "nm": "Sunday Schedules on Memorial Day",
        "sbj": "Sunday Schedules on May 25",
        "dtl": "On Memorial Day all lines operate on Sunday schedules.",
        "brf": "Sunday Schedules on Memorial Day May 25",
        "prty": "Medium",
        "cse": "Holiday",
        "efct": "Reduced service",
        "rtpidatafeed": "bustime",
        "mod": "20260524 15:55:26",
        "url": "https://www.actransit.org/node/19519",
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
| dtl | string | Detail text (may contain HTML) |
| brf | string | Brief description |
| cse | string | Cause |
| efct | string | Effect |
| prty | string | Priority (e.g. `"Medium"`) |
| rtpidatafeed | string | Data feed identifier |
| mod | string | Last modification timestamp (`YYYYMMDD HH:MM:SS`) |
| url | string | URL to the full bulletin page (optional) |
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
        "stpid": "50212",
        "stpnm": "Broadway & 12th St (12th St BART)",
        "lat": 37.803051,
        "lon": -122.272065,
        "geoid": "2476",
        "dtradd": ["string"],
        "dtrrem": ["string"]
      }
    ],
    "error": [{ "rtpidatafeed": "string", "stpid": "string", "rt": "string", "vid": "string", "msg": "string" }]
  }
}
```

| Field | Type | Description |
|-------|------|-------------|
| stops[].stpid | string | Stop ID |
| stops[].stpnm | string | Stop name |
| stops[].lat | decimal | Latitude |
| stops[].lon | decimal | Longitude |
| stops[].geoid | string | Geo location ID |
| stops[].dtradd | array | Detour IDs added at this stop (optional — only present when a detour is active) |
| stops[].dtrrem | array | Detour IDs removed at this stop (optional — only present when a detour is active) |

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

**Response Body** — Same structure as `/actrealtime/stop` (array of stop objects inside `bustime-response.stops`). When `limitFields=true`, only `stpid` and `stpnm` are returned per stop.

**Response Sample (JSON):**

```json
{
  "bustime-response": {
    "stops": [
      {
        "stpid": "59999",
        "stpnm": "7th St & Franklin St",
        "lat": 37.799014,
        "lon": -122.273177,
        "geoid": "2247"
      },
      {
        "stpid": "50212",
        "stpnm": "Broadway & 12th St (12th St BART)",
        "lat": 37.803051,
        "lon": -122.272065,
        "geoid": "2476",
        "dtradd": ["2738D8B2-F31A-479E-A3E6-EF602C44C845"],
        "dtrrem": []
      }
    ],
    "error": [
      {
        "rtpidatafeed": "bustime",
        "stpid": "string",
        "rt": "string",
        "vid": "string",
        "msg": "string"
      }
    ]
  }
}
```

> `dtradd` and `dtrrem` are only present on stops affected by an active detour.

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

**Response Body**

```json
{
  "bustime-response": {
    "vehicle": [
      {
        "vid": "1676",
        "rtpidatafeed": "bustime",
        "tmstmp": "20260524 16:32",
        "lat": "37.775203704833984",
        "lon": "-122.22671508789062",
        "hdg": "301",
        "pid": 8198,
        "pdist": 785,
        "rt": "51A",
        "des": "Rockridge BART",
        "dly": false,
        "spd": 0,
        "tablockid": "51001",
        "tatripid": "10551629",
        "zone": "",
        "mode": 0,
        "psgld": "EMPTY",
        "oid": "46052",
        "or": false,
        "blk": 145595101,
        "tripid": 12180010,
        "tripdyn": 0
      }
    ],
    "error": null
  }
}
```

| Field | Type | Description |
|-------|------|-------------|
| vid | string | Vehicle ID |
| rtpidatafeed | string | Data feed identifier (e.g. `"bustime"`) |
| tmstmp | string | Timestamp of position (`YYYYMMDD HH:MM` or `HH:MM:SS` per `tmres`) |
| lat | string | Latitude (returned as string) |
| lon | string | Longitude (returned as string) |
| hdg | string | Heading in degrees (`"0"`–`"359"`) |
| pid | integer | Active pattern ID |
| pdist | integer | Distance traveled along pattern (feet) |
| rt | string | Route designator |
| des | string | Destination |
| dly | boolean | Whether vehicle is delayed |
| spd | integer | Speed (mph) |
| tablockid | string | Tablet/block ID |
| tatripid | string | TA trip ID |
| zone | string | Zone identifier |
| mode | integer | Mode flag |
| psgld | string | Passenger load: `EMPTY`, `HALF_EMPTY`, `FULL`, etc. |
| oid | string | Operator ID |
| or | boolean | Whether operator is on relief |
| blk | integer | Block number |
| tripid | integer | Trip ID |
| tripdyn | integer | Trip dynamic flag |
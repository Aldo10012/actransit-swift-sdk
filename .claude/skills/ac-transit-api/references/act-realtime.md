# ActRealtime — BusTime Real-Time Endpoints

All responses use a `bustime-response` envelope. Supports optional JSONP via `callback` param.

```json
{ "bustime-response": { "<data_key>": [...], "error": [{ "msg": "string", ... }] } }
```

---

## `GET /actrealtime/detour`
Active detours affecting service.

**Query params:** `rt` (route), `rtdir` (direction, requires `rt`), `callback`, `token`

**Response key:** `dtrs`
`{ id, ver, st, desc, rtdirs: [{ rt, dir }], startdt, enddt }`

---

## `GET /actrealtime/direction`
Directions serviced by a route.

**Query params:** `rt` (required), `callback`, `token`

**Response key:** `directions` — `[{ id, name }]`

---

## `GET /actrealtime/line`
All routes in the system.

**Query params:** `callback`, `token`

**Response key:** `routes` — `[{ rt, rtnm, rtclr, rtdd, rtpidatafeed }]`

---

## `GET /actrealtime/locale`
Available language locales for the BusTime system.

**Query params:** `callback`, `token`

**Response key:** `locale` — `[{ localestring, displayname }]`

> Without a locale param, returns all supported codes. Unsupported locales fall back to system default.

---

## `GET /actrealtime/pattern`
Geo-positional points describing route pattern layouts.

**Query params:** `pid` OR `rt` (mutually exclusive, one required), `callback`, `token`
- `pid` — comma-delimited pattern IDs (max 10)
- `rt` — single route, returns all active patterns

**Response key:** `ptr`
```json
[{ "pid": 1, "ln": 5000, "rtdir": "string",
   "pt": [{ "seq": 1, "typ": "string", "stpid": "string", "stpnm": "string",
            "pdist": 0, "lat": 37.8, "lon": -122.2 }] }]
```

---

## `GET /actrealtime/prediction`
Real-time arrival/departure predictions for stops or vehicles.

**Query params:** `stpid` OR `vid` (mutually exclusive, one required), `rt`, `top`, `tmres` (`s`|`m`, default `m`), `showocprd` (bool), `callback`, `token`
- `stpid` — comma-delimited stop IDs (max 10)
- `vid` — comma-delimited vehicle IDs (max 10)

Results sorted by predicted arrival time ascending.

**Response key:** `prd`
```json
[{ "tmstmp": "string", "typ": "A|D", "stpnm": "string", "stpid": "string",
   "vid": "string", "dstp": 1234, "rt": "string", "rtdir": "string",
   "des": "string", "prdtm": "string", "dly": false, "prdctdn": "string",
   "zone": "string", "seq": 1 }]
```

| Field | Description |
|---|---|
| typ | `A` = arrival, `D` = departure |
| dstp | Distance to stop in feet |
| dly | Whether vehicle is delayed |
| prdctdn | Countdown string to predicted time |

---

## `GET /actrealtime/time`
Current BusTime system date/time for client synchronization.

**Query params:** `unixTime` (bool — if true, returns ms since Unix epoch UTC), `callback`, `token`

**Response key:** `tm`

---

## `GET /actrealtime/servicebulletin`
Active service bulletins for routes or stops.

**Query params:** `rt` OR `stpid` (at least one required), `rtdir`, `callback`, `token`

**Response key:** `sb`
`{ nm, sbj, dtl, brf, cse, efct, prty, mod, srvc: [{ rt, rtdir, stpid, stpnm }] }`

---

## `GET /actrealtime/stop`
Stops for a route/direction pair, or by stop ID.

**Query params:** (`rt` + `dir`) OR `stpid` (mutually exclusive), `callback`, `token`
- `stpid` — comma-delimited, up to 10

**Response key:** `stops`
`[{ stpid, stpnm, lat, lon, dtradd: ["string"], dtrrem: ["string"] }]`

---

## `GET /actrealtime/allstops`
All stops in the system, with optional route filter.

**Query params:** `rt` (optional), `callback`, `token`

---

## `GET /actrealtime/vehicle`
Real-time vehicle positions.

**Query params:** `vid` OR `rt` (one required), `callback`, `token`
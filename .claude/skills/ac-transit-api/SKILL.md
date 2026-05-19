---
name: ac-transit-api
description: Load AC Transit REST API documentation. Use when writing, debugging,
  or reviewing any code that calls the AC Transit API — including routes, stops,
  trips, vehicles, real-time predictions, GTFS data, or service alerts. Trigger on:
  "AC Transit", "actransit", "actrealtime", "gtfsrt", "bustime", route/stop/vehicle
  queries against the transit API, or any mention of AC Transit endpoints.
---

# AC Transit REST API

Base URL: `https://api.actransit.org/transit`
Auth: every request requires `?token=YOUR_TOKEN` as a query parameter.
Response format: JSON by default (except GTFS-RT endpoints which return Protocol Buffer binary, and GTFS download endpoints which return ZIP archives).

## Resource Groups

| Group | Reference File | Use When |
|---|---|---|
| Gtfs | @references/gtfs.md | Static schedule metadata, GTFS ZIP downloads |
| Routes | @references/routes.md | Route listings, stops, trips, waypoints, timetables, schedules |
| Trips | @references/trips.md | Trip cancellations and exceptions |
| GtfsRealTime | @references/gtfs-realtime.md | GTFS-RT protobuf feeds (trip updates, alerts, vehicle positions) |
| ActRealtime | @references/act-realtime.md | BusTime real-time: predictions, detours, service bulletins, vehicles |
| Vehicles | @references/vehicles.md | Vehicle characteristics and occupancy |
| Stops | @references/stops.md | Stop lookup, proximity search, predictions, routes at stop |

## Instructions

Read only the reference file(s) relevant to the user's current task.
Do not load all reference files at once unless the task spans multiple groups.
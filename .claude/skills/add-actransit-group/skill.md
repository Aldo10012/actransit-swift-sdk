---
name: add-actransit-group
description: Adds all endpoints for a single AC Transit API resource group into the SDK. Reads the group's reference file to enumerate every endpoint, invokes /add-actransit-endpoint for each one in order, commits each successful addition separately, then opens a PR. Invoke with the group name, e.g. "routes", "stops", "vehicles".
---

# Add AC Transit Group

Adds full SDK support for every endpoint in one AC Transit API resource group. The argument is the **group name** (first path segment), e.g. `routes`, `gtfs`, `trips`, `stops`, `vehicles`, `actrealtime`, `gtfsrt`.

---

## Step 1 — Read the reference file

Determine the reference file from the group name:

| Group | Reference file |
|---|---|
| `gtfs` | `@../../ac-transit-api/references/gtfs.md` |
| `routes` | `@../../ac-transit-api/references/routes.md` |
| `trips` | `@../../ac-transit-api/references/trips.md` |
| `stops` | `@../../ac-transit-api/references/stops.md` |
| `vehicles` | `@../../ac-transit-api/references/vehicles.md` |
| `actrealtime` | `@../../ac-transit-api/references/act-realtime.md` |
| `gtfsrt` | `@../../ac-transit-api/references/gtfs-realtime.md` |

Read the matching file and extract every endpoint path from the `` ## `GET /...` `` headings, **in document order**. Strip the leading `/` from each path. These are your work list.

> **Note:** A group's reference file may contain paths with different prefixes. For example, the `routes` reference file contains both `routes/{booking}` (list all) and `route/{routeName}/trips` (single route). Both belong to this group and must be included.

Example — for the `routes` group the work list would be:
```
routes/{booking}
route/{routeName}/{booking}
route/{routeName}/trips
route/{routeName}/tripsinstructions
route/{routeName}/directions
route/{routeName}/stops/{booking}
route/{routeName}/trip/{tripId}/pattern
route/{routeName}/trip/{tripId}/stops
route/{routeName}/vehicles
route/{routeName}/tripestimate
route/{routes}/waypoints/{booking}
route/{routes}/waypointsfast/{booking}
route/{routes}/tripstoday
route/{routes}/tripstops
route/{routes}/timetable/{direction}
route/{routes}/schedule/{booking}
route/{routeName}/destinations
route/{routes}/exceptions/{booking}
route/{routes}/profile
```

---

## Step 2 — Verify a clean working tree

Before making any changes, confirm there are no uncommitted modifications:

```bash
git status --porcelain
```

If the output is non-empty, stop and tell the user to commit or stash their changes first.

---

## Step 3 — Create a feature branch

Create (or resume) a branch named after the group:

```bash
git checkout -b feat/add-{group}-endpoints 2>/dev/null || git checkout feat/add-{group}-endpoints
```

The `||` fallback lets the skill resume safely if the branch already exists from a previous partial run.

---

## Step 4 — Process each endpoint

Work through the endpoint list **one at a time**, in order. For each path:

### 4a — Check if already implemented

Read `Sources/ACTransitSwift/Endpoints/{Group}Endpoint.swift` (if it exists). Search the `path` computed property's switch statement for a string literal that contains the non-parameter segments of the current path.

To find the non-parameter segments: take the path, drop any `{…}` segments, and check if the remaining literal parts all appear together in a single `case` line of the path switch.

Examples:
- `route/{routeName}/trips` → look for a path case containing both `route/` and `/trips`
- `routes/{booking}` → look for a path case containing `routes/` (and no further static segments after it)
- `route/{routeName}/trip/{tripId}/pattern` → look for a path case containing `route/`, `/trip/`, and `/pattern`

If a matching case is found, **skip silently** — add the path to the skipped-existing list and move to the next endpoint.

### 4b — Invoke /add-actransit-endpoint

Run `/add-actransit-endpoint {path}` for the current endpoint. That skill handles:
- Fetching live API docs and cross-referencing the reference file (updating the reference file if needed)
- Generating the Swift model
- Adding the endpoint case to the enum
- Adding the service method
- Writing all tests
- Running swiftlint and swiftformat

### 4c — Commit or record skip

After `/add-actransit-endpoint` returns, check git status:

```bash
git status --porcelain
```

- **If files were changed**: stage everything (including any reference file updates) and commit:
  ```bash
  git add Sources Tests .claude
  git commit -m "feat: add {path} endpoint"
  ```
  Add the path to the added list.

- **If no files were changed**: `/add-actransit-endpoint` determined the endpoint was binary or otherwise unsupported. Add to the skipped-binary list. Do not commit.

Repeat Step 4 for every remaining endpoint in the work list.

---

## Step 5 — Verify build and tests

After all endpoints have been processed, run a full build and test suite to confirm nothing is broken before opening the PR:

```bash
swift build 2>&1
swift test 2>&1
```

If either command fails, **stop**. Do not open a PR. Report the failure output and tell the user which commit introduced the breakage (use `git log --oneline` to identify it).

---

## Step 6 — Open a pull request

Push the branch and open a PR:

```bash
git push -u origin feat/add-{group}-endpoints
```

Then create the PR using `gh`, filling in the actual counts and path lists:

```bash
gh pr create \
  --title "feat: add {group} endpoints" \
  --body "$(cat <<'EOF'
## Summary

Adds SDK support for all `{group}` API endpoints.

### Added ({N} endpoints)
{bullet list of added paths}

### Skipped — binary response ({N} endpoints)
{bullet list of binary paths, or "None"}

### Skipped — already implemented ({N} endpoints)
{bullet list of already-existing paths, or "None"}

## Test plan
- [ ] `swift build` passes
- [ ] `swift test` passes (all suites green)
- [ ] Each new model decodes the live API response sample correctly
- [ ] Each new endpoint test verifies path, HTTP method, base URL, and token parameter

🤖 Generated with [Claude Code](https://claude.com/claude-code)
EOF
)"
```

---

## Step 7 — Report completion

Print a final summary:

```
Group: {group}
Branch: feat/add-{group}-endpoints
PR: {PR URL}

Added ({N}):
  ✓ {path}
  ✓ {path}
  ...

Skipped — binary ({N}):
  ✗ {path}
  ...

Skipped — already implemented ({N}):
  ↩ {path}
  ...
```

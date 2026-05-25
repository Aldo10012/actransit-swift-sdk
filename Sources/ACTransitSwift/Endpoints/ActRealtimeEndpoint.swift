import EZNetworking
import Foundation

enum ActRealtimeEndpoint {
    /// https://api.actransit.org/transit/actrealtime/detour?rt={rt}&rtdir={rtdir}&callback={callback}
    /// - Parameters:
    ///   - route: Single route designator (e.g., `20`, `NL`). Optional.
    ///   - direction: Route direction; requires `route`. Must match a direction ID from the direction endpoint. Optional.
    ///   - callback: JSONP callback function name. Optional.
    case detour(route: String? = nil, direction: String? = nil, callback: String? = nil)
    /// https://api.actransit.org/transit/actrealtime/direction?rt={rt}&callback={callback}
    /// - Parameters:
    ///   - route: Single route designator (e.g., `20`, `NL`).
    ///   - callback: JSONP callback function name. Optional.
    case direction(route: String, callback: String? = nil)
    /// https://api.actransit.org/transit/actrealtime/line?callback={callback}
    /// - Parameters:
    ///   - callback: JSONP callback function name. Optional.
    case line(callback: String? = nil)
    /// https://api.actransit.org/transit/actrealtime/locale?callback={callback}
    /// - Parameters:
    ///   - callback: JSONP callback function name. Optional.
    case locale(callback: String? = nil)
    /// https://api.actransit.org/transit/actrealtime/pattern?pid={pid}&rt={rt}&callback={callback}
    /// - Parameters:
    ///   - patternIds: Comma-delimited list of pattern IDs (max 10). Mutually exclusive with `route`.
    ///   - route: Single route identifier to return all active patterns. Mutually exclusive with `patternIds`.
    ///   - callback: JSONP callback function name. Optional.
    case pattern(patternIds: String? = nil, route: String? = nil, callback: String? = nil)
    /// https://api.actransit.org/transit/actrealtime/prediction?stpid={stpid}&rt={rt}&vid={vid}&top={top}&tmres={tmres}&callback={callback}&showocprd={showocprd}
    /// - Parameters:
    ///   - stopId: Comma-delimited stop IDs (max 10). Mutually exclusive with `vehicleId`.
    ///   - route: Comma-delimited route designators to filter results. Optional.
    ///   - vehicleId: Comma-delimited vehicle IDs (max 10). Mutually exclusive with `stopId`.
    ///   - top: Maximum number of predictions to return. Optional.
    ///   - tmres: Time resolution: `s` (seconds) or `m` (minutes). Defaults to `m`. Optional.
    ///   - showocprd: Whether to show occupancy prediction data. Optional.
    ///   - callback: JSONP callback function name. Optional.
    case prediction(stopId: String? = nil, route: String? = nil, vehicleId: String? = nil, top: Int? = nil, tmres: String? = nil, showocprd: Bool? = nil, callback: String? = nil)
    /// https://api.actransit.org/transit/actrealtime/time?unixTime={unixTime}&callback={callback}
    /// - Parameters:
    ///   - unixTime: If true, returns milliseconds elapsed since Unix epoch (UTC). Optional.
    ///   - callback: JSONP callback function name. Optional.
    case time(unixTime: Bool? = nil, callback: String? = nil)
    /// https://api.actransit.org/transit/actrealtime/servicebulletin?rt={rt}&rtdir={rtdir}&stpid={stpid}&callback={callback}
    /// - Parameters:
    ///   - routes: Comma-delimited route designators. Required if `stopId` is not provided.
    ///   - direction: Single route direction. Optional.
    ///   - stopId: Comma-delimited stop IDs. Required if `routes` is not provided.
    ///   - callback: JSONP callback function name. Optional.
    case serviceBulletin(routes: String? = nil, direction: String? = nil, stopId: String? = nil, callback: String? = nil)
    /// https://api.actransit.org/transit/actrealtime/stop?rt={rt}&dir={dir}&stpid={stpid}&callback={callback}
    /// - Parameters:
    ///   - route: Single route designator. Required with `direction` if `stopId` is not provided.
    ///   - direction: Single route direction. Required with `route` if `stopId` is not provided.
    ///   - stopId: Comma-delimited stop IDs (up to 10). Mutually exclusive with `route`/`direction`.
    ///   - callback: JSONP callback function name. Optional.
    case stop(route: String? = nil, direction: String? = nil, stopId: String? = nil, callback: String? = nil)
    /// https://api.actransit.org/transit/actrealtime/allstops?rt={rt}&limitFields={limitFields}&callback={callback}
    /// - Parameters:
    ///   - route: Single route designator to filter stops. Optional.
    ///   - limitFields: If true, return only `stpid` and `stpnm`. Optional.
    ///   - callback: JSONP callback function name. Optional.
    case allStops(route: String? = nil, limitFields: Bool? = nil, callback: String? = nil)
    /// https://api.actransit.org/transit/actrealtime/vehicle?vid={vid}&rt={rt}&tmres={tmres}&callback={callback}&lat={lat}&lng={lng}&searchRadius={searchRadius}
    /// - Parameters:
    ///   - vehicleId: Comma-delimited list of vehicle IDs. Mutually exclusive with `route`. Optional.
    ///   - route: Comma-delimited list of route designators. Mutually exclusive with `vehicleId`. Optional.
    ///   - tmres: Time resolution: `s` (seconds) or `m` (minutes). Defaults to `m`. Optional.
    ///   - callback: JSONP callback function name. Optional.
    ///   - lat: Latitude coordinate for geographic filtering. Requires `lng` and `searchRadius`. Optional.
    ///   - lng: Longitude coordinate for geographic filtering. Requires `lat` and `searchRadius`. Optional.
    ///   - searchRadius: Search distance in feet from `lat`/`lng`. Optional.
    case vehicle(vehicleId: String? = nil, route: String? = nil, tmres: String? = nil, callback: String? = nil, lat: Double? = nil, lng: Double? = nil, searchRadius: Double? = nil)
}

extension ActRealtimeEndpoint {
    var path: String {
        switch self {
        case .detour: "/actrealtime/detour"
        case .direction: "/actrealtime/direction"
        case .line: "/actrealtime/line"
        case .locale: "/actrealtime/locale"
        case .pattern: "/actrealtime/pattern"
        case .prediction: "/actrealtime/prediction"
        case .time: "/actrealtime/time"
        case .serviceBulletin: "/actrealtime/servicebulletin"
        case .stop: "/actrealtime/stop"
        case .allStops: "/actrealtime/allstops"
        case .vehicle: "/actrealtime/vehicle"
        }
    }

    // swiftlint:disable:next cyclomatic_complexity
    func getRequest(token: String) -> Request {
        let factory = RequestFactoryImpl()
        let url = ACTransitPlugins.apiBaseURL + path
        let tokenParam = HTTPParameter(key: Constants.tokenKey, value: token)

        switch self {
        case let .detour(route, direction, callback):
            var params: [HTTPParameter] = [tokenParam]
            if let route {
                params.append(HTTPParameter(key: "rt", value: route))
            }
            if let direction {
                params.append(HTTPParameter(key: "rtdir", value: direction))
            }
            if let callback {
                params.append(HTTPParameter(key: "callback", value: callback))
            }
            return factory.build(httpMethod: .GET, baseUrlString: url, parameters: params)
        case let .direction(route, callback):
            var params: [HTTPParameter] = [tokenParam, HTTPParameter(key: "rt", value: route)]
            if let callback {
                params.append(HTTPParameter(key: "callback", value: callback))
            }
            return factory.build(httpMethod: .GET, baseUrlString: url, parameters: params)
        case let .line(callback):
            var params: [HTTPParameter] = [tokenParam]
            if let callback {
                params.append(HTTPParameter(key: "callback", value: callback))
            }
            return factory.build(httpMethod: .GET, baseUrlString: url, parameters: params)
        case let .locale(callback):
            var params: [HTTPParameter] = [tokenParam]
            if let callback {
                params.append(HTTPParameter(key: "callback", value: callback))
            }
            return factory.build(httpMethod: .GET, baseUrlString: url, parameters: params)
        case let .pattern(patternIds, route, callback):
            var params: [HTTPParameter] = [tokenParam]
            if let patternIds {
                params.append(HTTPParameter(key: "pid", value: patternIds))
            }
            if let route {
                params.append(HTTPParameter(key: "rt", value: route))
            }
            if let callback {
                params.append(HTTPParameter(key: "callback", value: callback))
            }
            return factory.build(httpMethod: .GET, baseUrlString: url, parameters: params)
        case let .prediction(stopId, route, vehicleId, top, tmres, showocprd, callback):
            var params: [HTTPParameter] = [tokenParam]
            if let stopId {
                params.append(HTTPParameter(key: "stpid", value: stopId))
            }
            if let route {
                params.append(HTTPParameter(key: "rt", value: route))
            }
            if let vehicleId {
                params.append(HTTPParameter(key: "vid", value: vehicleId))
            }
            if let top {
                params.append(HTTPParameter(key: "top", value: String(top)))
            }
            if let tmres {
                params.append(HTTPParameter(key: "tmres", value: tmres))
            }
            if let showocprd {
                params.append(HTTPParameter(key: "showocprd", value: String(showocprd)))
            }
            if let callback {
                params.append(HTTPParameter(key: "callback", value: callback))
            }
            return factory.build(httpMethod: .GET, baseUrlString: url, parameters: params)
        case let .time(unixTime, callback):
            var params: [HTTPParameter] = [tokenParam]
            if let unixTime {
                params.append(HTTPParameter(key: "unixTime", value: String(unixTime)))
            }
            if let callback {
                params.append(HTTPParameter(key: "callback", value: callback))
            }
            return factory.build(httpMethod: .GET, baseUrlString: url, parameters: params)
        case let .serviceBulletin(routes, direction, stopId, callback):
            var params: [HTTPParameter] = [tokenParam]
            if let routes {
                params.append(HTTPParameter(key: "rt", value: routes))
            }
            if let direction {
                params.append(HTTPParameter(key: "rtdir", value: direction))
            }
            if let stopId {
                params.append(HTTPParameter(key: "stpid", value: stopId))
            }
            if let callback {
                params.append(HTTPParameter(key: "callback", value: callback))
            }
            return factory.build(httpMethod: .GET, baseUrlString: url, parameters: params)
        case let .stop(route, direction, stopId, callback):
            var params: [HTTPParameter] = [tokenParam]
            if let route {
                params.append(HTTPParameter(key: "rt", value: route))
            }
            if let direction {
                params.append(HTTPParameter(key: "dir", value: direction))
            }
            if let stopId {
                params.append(HTTPParameter(key: "stpid", value: stopId))
            }
            if let callback {
                params.append(HTTPParameter(key: "callback", value: callback))
            }
            return factory.build(httpMethod: .GET, baseUrlString: url, parameters: params)
        case let .allStops(route, limitFields, callback):
            var params: [HTTPParameter] = [tokenParam]
            if let route {
                params.append(HTTPParameter(key: "rt", value: route))
            }
            if let limitFields {
                params.append(HTTPParameter(key: "limitFields", value: String(limitFields)))
            }
            if let callback {
                params.append(HTTPParameter(key: "callback", value: callback))
            }
            return factory.build(httpMethod: .GET, baseUrlString: url, parameters: params)
        case let .vehicle(vehicleId, route, tmres, callback, lat, lng, searchRadius):
            var params: [HTTPParameter] = [tokenParam]
            if let vehicleId {
                params.append(HTTPParameter(key: "vid", value: vehicleId))
            }
            if let route {
                params.append(HTTPParameter(key: "rt", value: route))
            }
            if let tmres {
                params.append(HTTPParameter(key: "tmres", value: tmres))
            }
            if let callback {
                params.append(HTTPParameter(key: "callback", value: callback))
            }
            if let lat {
                params.append(HTTPParameter(key: "lat", value: String(lat)))
            }
            if let lng {
                params.append(HTTPParameter(key: "lng", value: String(lng)))
            }
            if let searchRadius {
                params.append(HTTPParameter(key: "searchRadius", value: String(searchRadius)))
            }
            return factory.build(httpMethod: .GET, baseUrlString: url, parameters: params)
        }
    }

    enum Constants {
        static let tokenKey = "token"
    }
}

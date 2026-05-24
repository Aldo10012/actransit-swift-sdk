import EZNetworking
import Foundation

enum StopsEndpoint {
    /// https://api.actransit.org/transit/stops
    case allStops
    /// https://api.actransit.org/transit/stops/summary
    case summary
    /// https://api.actransit.org/transit/stops/{latitude}/{longitude}/{distance}/{active}/{routeName}
    /// - Parameters:
    ///   - latitude: Search center latitude.
    ///   - longitude: Search center longitude.
    ///   - distance: Search radius in feet; default 500, max 25,000.
    ///   - active: Include inactive stops; default false.
    ///   - routeName: Filter to a specific route.
    ///
    /// - Note: Parameters are positional in the path. `active` is only included when `distance` is set;
    ///   `routeName` is only included when both `distance` and `active` are set. Omitting an earlier
    ///   optional silently drops all later optionals. Use `.nearby` for independent query-string params.
    case nearbyByPath(latitude: Double, longitude: Double, distance: Double? = nil, active: Bool? = nil, routeName: String? = nil)
    /// https://api.actransit.org/transit/stops/{latitude}/{longitude}?distance={distance}&active={active}&routeName={routeName}
    /// - Parameters:
    ///   - latitude: Search center latitude.
    ///   - longitude: Search center longitude.
    ///   - distance: Search radius in feet; default 500, max 25,000.
    ///   - active: Include inactive stops; default false.
    ///   - routeName: Filter to a specific route.
    case nearby(latitude: Double, longitude: Double, distance: Double? = nil, active: Bool? = nil, routeName: String? = nil)
    /// https://api.actransit.org/transit/stops/{stopId}/routes
    /// - Parameters:
    ///   - stopId: The stop whose intersecting routes should be retrieved.
    case stopRoutes(stopId: Int)
    /// https://api.actransit.org/transit/stops/{stopId}/tripstoday?routes={routes}&direction={direction}
    /// - Parameters:
    ///   - stopId: The stopId to query for.
    ///   - routes: Optional route(s) to filter by (comma delimited).
    ///   - direction: Optional direction or destination to filter by (comma delimited).
    case tripsToday(stopId: Int, routes: String? = nil, direction: String? = nil)
    /// https://api.actransit.org/transit/stop/{stopId}/destinations
    /// - Parameters:
    ///   - stopId: The stop whose destinations should be retrieved.
    case destinations(stopId: Int)
    /// https://api.actransit.org/transit/stop/{stopId}/profile
    /// - Parameters:
    ///   - stopId: 511's unique stop identifier whose stop information will be retrieved.
    case profile(stopId: Int)
}

extension StopsEndpoint {
    var path: String {
        switch self {
        case .allStops:
            "/stops"
        case .summary:
            "/stops/summary"
        case let .nearbyByPath(lat, lon, distance, active, routeName):
            buildNearbyByPathPath(lat: lat, lon: lon, distance: distance, active: active, routeName: routeName)
        case let .nearby(lat, lon, _, _, _):
            "/stops/\(lat)/\(lon)"
        case let .stopRoutes(stopId):
            "/stops/\(stopId)/routes"
        case let .tripsToday(stopId, _, _):
            "/stops/\(stopId)/tripstoday"
        case let .destinations(stopId):
            "/stop/\(stopId)/destinations"
        case let .profile(stopId):
            "/stop/\(stopId)/profile"
        }
    }

    private func buildNearbyByPathPath(lat: Double, lon: Double, distance: Double?, active: Bool?, routeName: String?) -> String {
        var p = "/stops/\(lat)/\(lon)"
        if let distance {
            p += "/\(distance)"
            if let active {
                p += "/\(active)"
                if let routeName {
                    p += "/\(routeName)"
                }
            }
        }
        return p
    }

    func getRequest(token: String) -> Request {
        let factory = RequestFactoryImpl()
        let url = ACTransitPlugins.apiBaseURL + path
        let tokenParam = HTTPParameter(key: Constants.tokenKey, value: token)
        switch self {
        case .allStops, .summary, .nearbyByPath, .stopRoutes, .destinations, .profile:
            return factory.build(httpMethod: .GET, baseUrlString: url, parameters: [tokenParam])
        case let .tripsToday(_, routes, direction):
            var params: [HTTPParameter] = [tokenParam]
            if let routes {
                params.append(HTTPParameter(key: "routes", value: routes))
            }
            if let direction {
                params.append(HTTPParameter(key: "direction", value: direction))
            }
            return factory.build(httpMethod: .GET, baseUrlString: url, parameters: params)
        case let .nearby(_, _, distance, active, routeName):
            var params: [HTTPParameter] = [tokenParam]
            if let distance {
                params.append(HTTPParameter(key: "distance", value: String(distance)))
            }
            if let active {
                params.append(HTTPParameter(key: "active", value: String(active)))
            }
            if let routeName {
                params.append(HTTPParameter(key: "routeName", value: routeName))
            }
            return factory.build(httpMethod: .GET, baseUrlString: url, parameters: params)
        }
    }

    enum Constants {
        static let tokenKey = "token"
    }
}

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
    case nearbyByPath(latitude: Double, longitude: Double, distance: Double? = nil, active: Bool? = nil, routeName: String? = nil)
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
        case .allStops, .summary, .nearbyByPath:
            return factory.build(httpMethod: .GET, baseUrlString: url, parameters: [tokenParam])
        }
    }

    enum Constants {
        static let tokenKey = "token"
    }
}

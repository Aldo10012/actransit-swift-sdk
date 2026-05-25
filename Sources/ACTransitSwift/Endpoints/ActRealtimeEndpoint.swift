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
}

extension ActRealtimeEndpoint {
    var path: String {
        switch self {
        case .detour: "/actrealtime/detour"
        case .direction: "/actrealtime/direction"
        case .line: "/actrealtime/line"
        case .locale: "/actrealtime/locale"
        case .pattern: "/actrealtime/pattern"
        }
    }

    func getRequest(token: String) -> Request {
        let factory = RequestFactoryImpl()
        let url = ACTransitPlugins.apiBaseURL + path
        let tokenParam = HTTPParameter(key: Constants.tokenKey, value: token)

        switch self {
        case let .detour(route, direction, callback):
            var params: [HTTPParameter] = [tokenParam]
            if let route { params.append(HTTPParameter(key: "rt", value: route)) }
            if let direction { params.append(HTTPParameter(key: "rtdir", value: direction)) }
            if let callback { params.append(HTTPParameter(key: "callback", value: callback)) }
            return factory.build(httpMethod: .GET, baseUrlString: url, parameters: params)
        case let .direction(route, callback):
            var params: [HTTPParameter] = [tokenParam, HTTPParameter(key: "rt", value: route)]
            if let callback { params.append(HTTPParameter(key: "callback", value: callback)) }
            return factory.build(httpMethod: .GET, baseUrlString: url, parameters: params)
        case let .line(callback):
            var params: [HTTPParameter] = [tokenParam]
            if let callback { params.append(HTTPParameter(key: "callback", value: callback)) }
            return factory.build(httpMethod: .GET, baseUrlString: url, parameters: params)
        case let .locale(callback):
            var params: [HTTPParameter] = [tokenParam]
            if let callback { params.append(HTTPParameter(key: "callback", value: callback)) }
            return factory.build(httpMethod: .GET, baseUrlString: url, parameters: params)
        case let .pattern(patternIds, route, callback):
            var params: [HTTPParameter] = [tokenParam]
            if let patternIds { params.append(HTTPParameter(key: "pid", value: patternIds)) }
            if let route { params.append(HTTPParameter(key: "rt", value: route)) }
            if let callback { params.append(HTTPParameter(key: "callback", value: callback)) }
            return factory.build(httpMethod: .GET, baseUrlString: url, parameters: params)
        }
    }

    enum Constants {
        static let tokenKey = "token"
    }
}

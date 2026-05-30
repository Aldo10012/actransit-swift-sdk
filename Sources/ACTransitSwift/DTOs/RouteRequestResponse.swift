import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=RouteRequestResponse
public struct RouteRequestResponse: Codable, Sendable {
    /// All routes serviced by the system.
    public let routes: [BusTimeRoute]
    /// Errors from request processing.
    public let error: [BusTimeError]?

    public init(routes: [BusTimeRoute], error: [BusTimeError]? = nil) {
        self.routes = routes
        self.error = error
    }
}

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=RequestResponseOfRouteRequestResponse
public typealias RequestResponseOfRouteRequestResponse = BusTimeResponse<RouteRequestResponse>

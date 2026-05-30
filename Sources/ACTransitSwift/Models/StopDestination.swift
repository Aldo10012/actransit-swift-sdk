import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=StopDestination
public struct StopDestination: Codable, Sendable {
    public let stopId: Int
    public let status: String
    public let routeDestinations: [StopRouteDestination]

    public init(stopId: Int, status: String, routeDestinations: [StopRouteDestination]) {
        self.stopId = stopId
        self.status = status
        self.routeDestinations = routeDestinations
    }

    enum CodingKeys: String, CodingKey {
        case stopId = "StopId"
        case status = "Status"
        case routeDestinations = "RouteDestinations"
    }

    public static let sample = StopDestination(
        stopId: 55888,
        status: "Active",
        routeDestinations: [.sample]
    )

    public static func make(
        stopId: Int = sample.stopId,
        status: String = sample.status,
        routeDestinations: [StopRouteDestination] = sample.routeDestinations
    ) -> StopDestination {
        StopDestination(stopId: stopId, status: status, routeDestinations: routeDestinations)
    }
}

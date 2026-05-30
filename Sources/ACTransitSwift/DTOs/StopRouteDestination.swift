import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=StopRouteDestination
public struct StopRouteDestination: Codable, Sendable {
    public let routeId: String
    public let directionId: Int
    public let direction: String
    public let destination: String
    /// Scheduled time of the last bus passing this stop for the route/direction. Format: "yyyy-MM-ddTHH:mm:ss" (no timezone).
    public let finalPassingTime: String
    public let status: String

    public init(routeId: String, directionId: Int, direction: String, destination: String, finalPassingTime: String, status: String) {
        self.routeId = routeId
        self.directionId = directionId
        self.direction = direction
        self.destination = destination
        self.finalPassingTime = finalPassingTime
        self.status = status
    }

    enum CodingKeys: String, CodingKey {
        case routeId = "RouteId"
        case directionId = "DirectionId"
        case direction = "Direction"
        case destination = "Destination"
        case finalPassingTime = "FinalPassingTime"
        case status = "Status"
    }

    public static let sample = StopRouteDestination(
        routeId: "72",
        directionId: 0,
        direction: "Southbound",
        destination: "Jack London Square",
        finalPassingTime: "2026-05-24T23:45:00",
        status: "Active"
    )

    public static func make(
        routeId: String = sample.routeId,
        directionId: Int = sample.directionId,
        direction: String = sample.direction,
        destination: String = sample.destination,
        finalPassingTime: String = sample.finalPassingTime,
        status: String = sample.status
    ) -> StopRouteDestination {
        StopRouteDestination(routeId: routeId, directionId: directionId, direction: direction, destination: destination, finalPassingTime: finalPassingTime, status: status)
    }
}

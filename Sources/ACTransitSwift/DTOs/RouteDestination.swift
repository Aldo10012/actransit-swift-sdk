import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=RouteDestination
public struct RouteDestination: Codable, Sendable {
    /// Name of the route.
    public let routeId: String
    /// Numeric code that represents the direction of a route.
    public let directionId: Int
    /// String that indicates the cardinal direction.
    public let direction: String
    /// String that indicates the destination of the route.
    public let destination: String

    public init(routeId: String, directionId: Int, direction: String, destination: String) {
        self.routeId = routeId
        self.directionId = directionId
        self.direction = direction
        self.destination = destination
    }

    enum CodingKeys: String, CodingKey {
        case routeId = "RouteId"
        case directionId = "DirectionId"
        case direction = "Direction"
        case destination = "Destination"
    }

    // MARK: - Mock Data

    public static let sample = RouteDestination(
        routeId: "72",
        directionId: 0,
        direction: "Southbound",
        destination: "To Jack London Square"
    )

    public static func make(
        routeId: String = sample.routeId,
        directionId: Int = sample.directionId,
        direction: String = sample.direction,
        destination: String = sample.destination
    ) -> RouteDestination {
        RouteDestination(routeId: routeId, directionId: directionId, direction: direction, destination: destination)
    }
}

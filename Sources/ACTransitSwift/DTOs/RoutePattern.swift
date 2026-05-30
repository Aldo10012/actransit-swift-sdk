import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=RoutePattern
public struct RoutePattern: Codable, Sendable {
    public let directionId: Int
    public let direction: String
    public let destination: String
    public let firstPlaceId: String
    public let lastPlaceId: String
    public let isDefault: Bool
    public let totalDistance: Int
    public let waypoints: [RouteWaypoint]

    public init(directionId: Int, direction: String, destination: String, firstPlaceId: String, lastPlaceId: String, isDefault: Bool, totalDistance: Int, waypoints: [RouteWaypoint]) {
        self.directionId = directionId
        self.direction = direction
        self.destination = destination
        self.firstPlaceId = firstPlaceId
        self.lastPlaceId = lastPlaceId
        self.isDefault = isDefault
        self.totalDistance = totalDistance
        self.waypoints = waypoints
    }

    enum CodingKeys: String, CodingKey {
        case directionId = "DirectionId"
        case direction = "Direction"
        case destination = "Destination"
        case firstPlaceId = "FirstPlaceId"
        case lastPlaceId = "LastPlaceId"
        case isDefault = "IsDefault"
        case totalDistance = "TotalDistance"
        case waypoints = "Waypoints"
    }

    // MARK: - Mock Data

    public static let sample = RoutePattern(
        directionId: 5,
        direction: "NORTHBOUND",
        destination: "To Contra Costa College",
        firstPlaceId: "2NWN",
        lastPlaceId: "CCCO",
        isDefault: true,
        totalDistance: 74035,
        waypoints: [RouteWaypoint.sample]
    )

    public static func make(
        directionId: Int = sample.directionId,
        direction: String = sample.direction,
        destination: String = sample.destination,
        firstPlaceId: String = sample.firstPlaceId,
        lastPlaceId: String = sample.lastPlaceId,
        isDefault: Bool = sample.isDefault,
        totalDistance: Int = sample.totalDistance,
        waypoints: [RouteWaypoint] = sample.waypoints
    ) -> RoutePattern {
        RoutePattern(directionId: directionId, direction: direction, destination: destination, firstPlaceId: firstPlaceId, lastPlaceId: lastPlaceId, isDefault: isDefault, totalDistance: totalDistance, waypoints: waypoints)
    }
}

import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=RoutePatternFast
public struct RoutePatternFast: Codable, Sendable {
    public let directionId: Int
    public let direction: String
    public let destination: String
    public let firstPlaceId: String
    public let lastPlaceId: String
    public let isDefault: Bool
    public let totalDistance: Int
    /// Waypoints encoded as "latitude,longitude" strings.
    public let waypoints: [String]

    public init(directionId: Int, direction: String, destination: String, firstPlaceId: String, lastPlaceId: String, isDefault: Bool, totalDistance: Int, waypoints: [String]) {
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

    public static let sample = RoutePatternFast(
        directionId: 5,
        direction: "NORTHBOUND",
        destination: "To Contra Costa College",
        firstPlaceId: "2NWN",
        lastPlaceId: "CCCO",
        isDefault: true,
        totalDistance: 74035,
        waypoints: ["37.796567,-122.27785", "37.796486,-122.277406"]
    )

    public static func make(
        directionId: Int = sample.directionId,
        direction: String = sample.direction,
        destination: String = sample.destination,
        firstPlaceId: String = sample.firstPlaceId,
        lastPlaceId: String = sample.lastPlaceId,
        isDefault: Bool = sample.isDefault,
        totalDistance: Int = sample.totalDistance,
        waypoints: [String] = sample.waypoints
    ) -> RoutePatternFast {
        RoutePatternFast(directionId: directionId, direction: direction, destination: destination, firstPlaceId: firstPlaceId, lastPlaceId: lastPlaceId, isDefault: isDefault, totalDistance: totalDistance, waypoints: waypoints)
    }
}

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=RouteWaypointsFast
public struct RouteWaypointsFast: Codable, Sendable {
    public let booking: String
    public let routeAlpha: String
    public let patterns: [RoutePatternFast]

    public init(booking: String, routeAlpha: String, patterns: [RoutePatternFast]) {
        self.booking = booking
        self.routeAlpha = routeAlpha
        self.patterns = patterns
    }

    enum CodingKeys: String, CodingKey {
        case booking = "Booking"
        case routeAlpha = "RouteAlpha"
        case patterns = "Patterns"
    }

    // MARK: - Mock Data

    public static let sample = RouteWaypointsFast(
        booking: "2604SP",
        routeAlpha: "72",
        patterns: [RoutePatternFast.sample]
    )

    public static func make(
        booking: String = sample.booking,
        routeAlpha: String = sample.routeAlpha,
        patterns: [RoutePatternFast] = sample.patterns
    ) -> RouteWaypointsFast {
        RouteWaypointsFast(booking: booking, routeAlpha: routeAlpha, patterns: patterns)
    }
}

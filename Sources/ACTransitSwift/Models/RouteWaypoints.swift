import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=RouteWaypoint
public struct RouteWaypoint: Codable, Sendable {
    public let orderId: Int
    public let latitude: Double
    public let longitude: Double
    public let heading: Double
    public let distanceToNextStop: Int
    public let distanceFromStart: Int
    public let stopSequence: Int

    public init(orderId: Int, latitude: Double, longitude: Double, heading: Double, distanceToNextStop: Int, distanceFromStart: Int, stopSequence: Int) {
        self.orderId = orderId
        self.latitude = latitude
        self.longitude = longitude
        self.heading = heading
        self.distanceToNextStop = distanceToNextStop
        self.distanceFromStart = distanceFromStart
        self.stopSequence = stopSequence
    }

    enum CodingKeys: String, CodingKey {
        case orderId = "OrderID"
        case latitude = "Latitude"
        case longitude = "Longitude"
        case heading = "Heading"
        case distanceToNextStop = "DistanceToNextStop"
        case distanceFromStart = "DistanceFromStart"
        case stopSequence = "StopSequence"
    }

    // MARK: - Mock Data

    public static let sample = RouteWaypoint(
        orderId: 0,
        latitude: 37.796567,
        longitude: -122.27785,
        heading: 131.4,
        distanceToNextStop: 723,
        distanceFromStart: 0,
        stopSequence: 1
    )

    public static func make(
        orderId: Int = sample.orderId,
        latitude: Double = sample.latitude,
        longitude: Double = sample.longitude,
        heading: Double = sample.heading,
        distanceToNextStop: Int = sample.distanceToNextStop,
        distanceFromStart: Int = sample.distanceFromStart,
        stopSequence: Int = sample.stopSequence
    ) -> RouteWaypoint {
        RouteWaypoint(orderId: orderId, latitude: latitude, longitude: longitude, heading: heading, distanceToNextStop: distanceToNextStop, distanceFromStart: distanceFromStart, stopSequence: stopSequence)
    }
}

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

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=RouteWaypoints
public struct RouteWaypoints: Codable, Sendable {
    public let booking: String
    public let routeAlpha: String
    public let patterns: [RoutePattern]

    public init(booking: String, routeAlpha: String, patterns: [RoutePattern]) {
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

    public static let sample = RouteWaypoints(
        booking: "2604SP",
        routeAlpha: "72",
        patterns: [RoutePattern.sample]
    )

    public static func make(
        booking: String = sample.booking,
        routeAlpha: String = sample.routeAlpha,
        patterns: [RoutePattern] = sample.patterns
    ) -> RouteWaypoints {
        RouteWaypoints(booking: booking, routeAlpha: routeAlpha, patterns: patterns)
    }
}

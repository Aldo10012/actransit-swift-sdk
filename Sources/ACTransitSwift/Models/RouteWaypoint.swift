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

import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=StopOrder
public struct StopOrder: Codable, Sendable {
    /// The Stop Id511
    public let stopId: Int
    /// Name of the stop.
    public let name: String
    /// Stop for the position to evaulate
    public let latitude: Double
    /// Stop for the position to evaulate.
    public let longitude: Double
    /// The order of the stop in the current line and direction/destination.
    public let order: Int

    public init(stopId: Int, name: String, latitude: Double, longitude: Double, order: Int) {
        self.stopId = stopId
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.order = order
    }

    enum CodingKeys: String, CodingKey {
        case stopId = "StopId"
        case name = "Name"
        case latitude = "Latitude"
        case longitude = "Longitude"
        case order = "Order"
    }

    // MARK: - Mock Data

    public static let sample = StopOrder(
        stopId: 51632,
        name: "2nd St & Washington St",
        latitude: 37.7965673,
        longitude: -122.2778501,
        order: 1
    )

    public static func make(
        stopId: Int = sample.stopId,
        name: String = sample.name,
        latitude: Double = sample.latitude,
        longitude: Double = sample.longitude,
        order: Int = sample.order
    ) -> StopOrder {
        StopOrder(stopId: stopId, name: name, latitude: latitude, longitude: longitude, order: order)
    }
}

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=RouteStopOrder
public struct RouteStopOrder: Codable, Sendable {
    /// Route Name
    public let route: String
    /// The direction of the line this stop serves
    public let direction: String
    /// The destination of the line this stop serves
    public let destination: String
    public let stops: [StopOrder]

    public init(route: String, direction: String, destination: String, stops: [StopOrder]) {
        self.route = route
        self.direction = direction
        self.destination = destination
        self.stops = stops
    }

    enum CodingKeys: String, CodingKey {
        case route = "Route"
        case direction = "Direction"
        case destination = "Destination"
        case stops = "Stops"
    }

    // MARK: - Mock Data

    public static let sample = RouteStopOrder(
        route: "72",
        direction: "Northbound",
        destination: "To Contra Costa College",
        stops: [StopOrder.sample]
    )

    public static func make(
        route: String = sample.route,
        direction: String = sample.direction,
        destination: String = sample.destination,
        stops: [StopOrder] = sample.stops
    ) -> RouteStopOrder {
        RouteStopOrder(route: route, direction: direction, destination: destination, stops: stops)
    }
}

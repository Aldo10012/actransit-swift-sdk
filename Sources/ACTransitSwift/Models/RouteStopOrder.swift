import Foundation

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

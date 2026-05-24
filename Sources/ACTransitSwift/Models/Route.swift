import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=Route
public struct Route: Codable, Sendable {
    /// Route's unique identifier
    public let routeId: String
    /// The Route's name as seen by the public
    public let name: String
    /// Additional information regarding the route
    public let description: String

    public init(routeId: String, name: String, description: String) {
        self.routeId = routeId
        self.name = name
        self.description = description
    }

    enum CodingKeys: String, CodingKey {
        case routeId = "RouteId"
        case name = "Name"
        case description = "Description"
    }

    // MARK: - Mock Data

    public static let sample = Route(
        routeId: "72",
        name: "72",
        description: "CCC - San Pablo"
    )

    public static func make(
        routeId: String = sample.routeId,
        name: String = sample.name,
        description: String = sample.description
    ) -> Route {
        Route(routeId: routeId, name: name, description: description)
    }
}

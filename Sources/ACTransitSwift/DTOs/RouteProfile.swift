import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=RouteProfile
public struct RouteProfile: Codable, Sendable {
    /// Name of the route.
    public let routeId: String
    /// Route description.
    public let profile: String

    public init(routeId: String, profile: String) {
        self.routeId = routeId
        self.profile = profile
    }

    enum CodingKeys: String, CodingKey {
        case routeId = "RouteId"
        case profile = "Profile"
    }

    // MARK: - Mock Data

    public static let sample = RouteProfile(
        routeId: "72",
        profile: "Contra Costa College to Jack London Square via San Pablo Ave., El Cerrito del Norte BART, and Downtown Oakland."
    )

    public static func make(
        routeId: String = sample.routeId,
        profile: String = sample.profile
    ) -> RouteProfile {
        RouteProfile(routeId: routeId, profile: profile)
    }
}

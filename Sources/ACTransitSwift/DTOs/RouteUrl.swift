import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=RouteUrl
public struct RouteUrl: Codable, Sendable {
    public let routeId: String
    public let url: String

    public init(routeId: String, url: String) {
        self.routeId = routeId
        self.url = url
    }

    enum CodingKeys: String, CodingKey {
        case routeId = "RouteId"
        case url = "Url"
    }

    public static let sample = RouteUrl(
        routeId: "72",
        url: "https://511.org/transit/schedules/72"
    )

    public static func make(
        routeId: String = sample.routeId,
        url: String = sample.url
    ) -> RouteUrl {
        RouteUrl(routeId: routeId, url: url)
    }
}

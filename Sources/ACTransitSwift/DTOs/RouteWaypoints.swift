import Foundation

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

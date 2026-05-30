import Foundation

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

import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=TripScheduleInfo
public struct TripScheduleInfo: Codable, Sendable {
    /// Unique id that represents a specific schedule name for the period of time associated with the requested data.
    public let bookingId: String
    /// Collection of route descriptions.
    public let routeProfiles: [RouteProfile]
    /// Collection of service date exceptions.
    public let dateExceptions: [DateException]
    /// Collection of stops for the requested routes.
    public let stops: [TripScheduleStop]
    /// Collection of route schedules.
    public let routes: [TripScheduleRoute]

    public init(bookingId: String, routeProfiles: [RouteProfile], dateExceptions: [DateException], stops: [TripScheduleStop], routes: [TripScheduleRoute]) {
        self.bookingId = bookingId
        self.routeProfiles = routeProfiles
        self.dateExceptions = dateExceptions
        self.stops = stops
        self.routes = routes
    }

    enum CodingKeys: String, CodingKey {
        case bookingId = "BookingId"
        case routeProfiles = "RouteProfiles"
        case dateExceptions = "DateExceptions"
        case stops = "Stops"
        case routes = "Routes"
    }

    // MARK: - Mock Data

    public static let sample = TripScheduleInfo(
        bookingId: "2604SP",
        routeProfiles: [RouteProfile.sample],
        dateExceptions: [],
        stops: [TripScheduleStop.sample],
        routes: [TripScheduleRoute.sample]
    )

    public static func make(
        bookingId: String = sample.bookingId,
        routeProfiles: [RouteProfile] = sample.routeProfiles,
        dateExceptions: [DateException] = sample.dateExceptions,
        stops: [TripScheduleStop] = sample.stops,
        routes: [TripScheduleRoute] = sample.routes
    ) -> TripScheduleInfo {
        TripScheduleInfo(bookingId: bookingId, routeProfiles: routeProfiles, dateExceptions: dateExceptions, stops: stops, routes: routes)
    }
}

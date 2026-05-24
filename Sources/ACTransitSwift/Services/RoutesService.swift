import EZNetworking
import Foundation

public struct RoutesService {
    private let token: String
    private let performer: RequestPerformable

    init(token: String, performer: RequestPerformable) {
        self.token = token
        self.performer = performer
    }

    /// Retrieves all stops for a given route, organized by direction or stop pattern.
    /// - Parameters:
    ///   - routeName: The route identifier.
    ///   - booking: Schedule identifier. Use `Current` or `nil` for the current schedule, `Next` for the next, or a specific BookingId.
    ///   - direction: Filter by direction.
    ///   - destination: Filter by destination; should match actrealtime API values.
    ///   - scheduleType: Filter by schedule type: `Today`, `Saturday`, `Sunday`, or `Weekday`.
    ///   - byPattern: If true, return stops per stop pattern. Default false.
    public func stops(routeName: String, booking: String? = nil, direction: String? = nil, destination: String? = nil, scheduleType: TripScheduleType? = nil, byPattern: Bool? = nil) async throws -> [RouteStopOrder] {
        try await performer.perform(
            request: RoutesEndpoint.stops(routeName: routeName, booking: booking, direction: direction, destination: destination, scheduleType: scheduleType, byPattern: byPattern).getRequest(token: token),
            decodeTo: [RouteStopOrder].self
        )
    }

    /// Retrieves all directions serviced by a given route.
    /// - Parameters:
    ///   - routeName: The route identifier.
    public func directions(routeName: String) async throws -> [String] {
        try await performer.perform(
            request: RoutesEndpoint.directions(routeName: routeName).getRequest(token: token),
            decodeTo: [String].self
        )
    }

    /// Retrieves trips with operator driving instructions for a given route.
    /// - Parameters:
    ///   - routeName: The route identifier.
    ///   - direction: Filter by direction of travel.
    ///   - scheduleType: Required. The schedule type: `Weekday`, `Saturday`, or `Sunday`.
    public func tripsInstructions(routeName: String, direction: String? = nil, scheduleType: TripScheduleType) async throws -> [TripInstruction] {
        try await performer.perform(
            request: RoutesEndpoint.tripsInstructions(routeName: routeName, direction: direction, scheduleType: scheduleType).getRequest(token: token),
            decodeTo: [TripInstruction].self
        )
    }

    /// Retrieves all trips for a given route, optionally filtered by direction and schedule type.
    /// - Parameters:
    ///   - routeName: The route identifier.
    ///   - direction: Filter results by direction of travel.
    ///   - scheduleType: Filter by schedule type: `Weekday`, `Saturday`, or `Sunday`.
    public func trips(routeName: String, direction: String? = nil, scheduleType: TripScheduleType? = nil) async throws -> [Trip] {
        try await performer.perform(
            request: RoutesEndpoint.trips(routeName: routeName, direction: direction, scheduleType: scheduleType).getRequest(token: token),
            decodeTo: [Trip].self
        )
    }

    /// Retrieves details for a specific route in a given booking period.
    /// - Parameters:
    ///   - routeName: The route to be retrieved.
    ///   - booking: Schedule identifier. Use `Current` or `nil` for the current schedule, `Next` for the next, or a specific BookingId.
    public func route(routeName: String, booking: String? = nil) async throws -> Route {
        try await performer.perform(
            request: RoutesEndpoint.route(routeName: routeName, booking: booking).getRequest(token: token),
            decodeTo: Route.self
        )
    }

    /// Retrieves all AC Transit routes for a given booking period.
    /// - Parameters:
    ///   - booking: Unique id representing a specific schedule. Use `Current` or `nil` for the current schedule, `Next` for the next schedule, or a specific BookingId.
    ///   - sortType: Indicates how the routes should be sorted. Default is natural sort. Options: `Alphabetical` or `Natural`.
    public func routes(booking: String? = nil, sortType: RouteSortType? = nil) async throws -> [RouteDivision] {
        try await performer.perform(
            request: RoutesEndpoint.routes(booking: booking, sortType: sortType).getRequest(token: token),
            decodeTo: [RouteDivision].self
        )
    }
}

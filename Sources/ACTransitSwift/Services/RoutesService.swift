import EZNetworking
import Foundation

public struct RoutesService {
    private let token: String
    private let performer: RequestPerformable

    init(token: String, performer: RequestPerformable) {
        self.token = token
        self.performer = performer
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

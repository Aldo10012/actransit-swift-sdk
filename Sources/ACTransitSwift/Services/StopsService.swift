import EZNetworking
import Foundation

public struct StopsService {
    private let token: String
    private let performer: RequestPerformable

    init(token: String, performer: RequestPerformable) {
        self.token = token
        self.performer = performer
    }

    /// Retrieves all currently active AC Transit stops.
    public func allStops() async throws -> [Stop] {
        try await performer.perform(
            request: StopsEndpoint.allStops.getRequest(token: token),
            decodeTo: [Stop].self
        )
    }

    /// Retrieves a summary count and last-updated timestamp for active stops.
    public func summary() async throws -> StopSummary {
        try await performer.perform(
            request: StopsEndpoint.summary.getRequest(token: token),
            decodeTo: StopSummary.self
        )
    }

    /// Retrieves stops within a radius of the given coordinates, with all optional parameters embedded in the path.
    /// - Parameters:
    ///   - latitude: Search center latitude.
    ///   - longitude: Search center longitude.
    ///   - distance: Search radius in feet; default 500, max 25,000.
    ///   - active: Include inactive stops; default false.
    ///   - routeName: Filter to a specific route.
    public func nearbyByPath(latitude: Double, longitude: Double, distance: Double? = nil, active: Bool? = nil, routeName: String? = nil) async throws -> [Stop] {
        try await performer.perform(
            request: StopsEndpoint.nearbyByPath(latitude: latitude, longitude: longitude, distance: distance, active: active, routeName: routeName).getRequest(token: token),
            decodeTo: [Stop].self
        )
    }
}

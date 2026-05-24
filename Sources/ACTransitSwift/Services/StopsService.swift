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
}

@preconcurrency import EZNetworking
import Foundation

public struct GTFSService {
    private let token: String
    private let performer: RequestPerformable

    init(token: String, performer: RequestPerformable) {
        self.token = token
        self.performer = performer
    }

    /// Info for the currently active GTFS schedule.
    public func active() async throws -> GtfsScheduleInfo {
        try await performer.perform(request: GTFSEndpoint.active.getRequest(token: token), decodeTo: GtfsScheduleInfo.self)
    }

    /// All schedules: past, current, and future.
    public func all() async throws -> [GtfsInfo] {
        try await performer.perform(request: GTFSEndpoint.all.getRequest(token: token), decodeTo: [GtfsInfo].self)
    }
}

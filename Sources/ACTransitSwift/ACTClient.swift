import EZNetworking
import Foundation

public class ACTClient {
    private let performer: RequestPerformable

    public convenience init() {
        self.init(performer: RequestPerformer())
    }

    init(performer: RequestPerformable) {
        self.performer = performer
    }

    public func getGtfs() async throws -> GtfsScheduleInfo {
        try await performer.perform(request: ACTEndpoint.gtfs.getRequest(), decodeTo: GtfsScheduleInfo.self)
    }

    public func getGtfsAll() async throws -> [GtfsInfo] {
        try await performer.perform(request: ACTEndpoint.gtfsAll.getRequest(), decodeTo: [GtfsInfo].self)
    }
}

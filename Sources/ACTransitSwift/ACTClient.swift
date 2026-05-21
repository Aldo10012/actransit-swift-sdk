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

    public func getTripsCanceled(
        lastIncidentUniqueId: Int? = nil,
        lastOpenDateTime: Date? = nil,
        tripDateTimeFrom: Date? = nil,
        tripDateTimeTo: Date? = nil
    ) async throws -> [TripException] {
        try await performer.perform(
            request: ACTEndpoint.tripsCanceled(
                lastIncidentUniqueId: lastIncidentUniqueId,
                lastOpenDateTime: lastOpenDateTime,
                tripDateTimeFrom: tripDateTimeFrom,
                tripDateTimeTo: tripDateTimeTo
            ).getRequest(),
            decodeTo: [TripException].self
        )
    }
}

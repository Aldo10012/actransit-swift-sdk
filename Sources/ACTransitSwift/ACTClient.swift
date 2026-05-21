import EZNetworking
import Foundation

public class ACTClient {
    private let token: String
    private let performer: RequestPerformable

    public convenience init() {
        self.init(token: ACTSwiftPlugins.apiToken, performer: RequestPerformer())
    }

    init(token: String, performer: RequestPerformable) {
        self.token = token
        self.performer = performer
    }

    public func getGtfs() async throws -> GtfsScheduleInfo {
        try await performer.perform(request: ACTEndpoint.gtfs.getRequest(token: token), decodeTo: GtfsScheduleInfo.self)
    }

    public func getGtfsAll() async throws -> [GtfsInfo] {
        try await performer.perform(request: ACTEndpoint.gtfsAll.getRequest(token: token), decodeTo: [GtfsInfo].self)
    }

    public func getTripsTripCancellationInfo(tripNumber: Int) async throws -> TripCancellationInfo {
        try await performer.perform(
            request: ACTEndpoint.tripsTripCancellationInfo(tripNumber: tripNumber).getRequest(token: token),
            decodeTo: TripCancellationInfo.self
        )
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
            ).getRequest(token: token),
            decodeTo: [TripException].self
        )
    }
}

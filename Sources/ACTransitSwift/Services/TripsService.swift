import EZNetworking
import Foundation

public struct TripsService {
    private let token: String
    private let performer: RequestPerformable

    init(token: String, performer: RequestPerformable) {
        self.token = token
        self.performer = performer
    }

    /// Canceled revenue trips within an optional date range.
    public func canceled(
        lastIncidentUniqueId: Int? = nil,
        lastOpenDateTime: Date? = nil,
        tripDateTimeFrom: Date? = nil,
        tripDateTimeTo: Date? = nil
    ) async throws -> [TripException] {
        try await performer.perform(
            request: TripsEndpoint.canceled(
                lastIncidentUniqueId: lastIncidentUniqueId,
                lastOpenDateTime: lastOpenDateTime,
                tripDateTimeFrom: tripDateTimeFrom,
                tripDateTimeTo: tripDateTimeTo
            ).getRequest(token: token),
            decodeTo: [TripException].self
        )
    }

    /// Cancellation details for a specific trip number.
    public func cancellationInfo(tripNumber: Int) async throws -> TripCancellationInfo {
        try await performer.perform(
            request: TripsEndpoint.cancellationInfo(tripNumber: tripNumber).getRequest(token: token),
            decodeTo: TripCancellationInfo.self
        )
    }
}

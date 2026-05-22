@testable import ACTransitSwift
import EZNetworking
import Foundation
import Testing

@Suite("Test TripsService")
final class TripsServiceTests {
    private var sut: TripsService

    init() {
        sut = TripsService(token: "mockToken", performer: MockRequestPerformer())
    }

    private func setup(mockJSON: Data?) {
        var performer = MockRequestPerformer()
        performer.fixture = mockJSON
        sut = TripsService(token: "mockToken", performer: performer)
    }

    // MARK: - Tests

    @Test("test .cancellationInfo() success case")
    func cancellationInfo() async throws {
        let jsonString = """
        {
            "RouteAlpha": "51A",
            "Direction": "NB",
            "BookingId": "25FASU",
            "Canceled": true,
            "Reinstated": false,
            "TripNumber": 1001,
            "InternalTripNumber": 5001,
            "TripStartTime": "2025-05-01T09:00:00.0000000-07:00",
            "ScheduleType": "Weekday",
            "NextTripNumber": 1002,
            "NextInternalTripNumber": 5002,
            "NextTripStartTime": "2025-05-01T09:30:00.0000000-07:00",
            "NextScheduleType": "Weekday",
            "PrevTripNumber": 1000,
            "PrevInternalTripNumber": 5000,
            "PrevTripStartTime": "2025-05-01T08:30:00.0000000-07:00",
            "PrevScheduleType": "Weekday"
        }
        """
        setup(mockJSON: jsonString.data(using: .utf8))

        let result = try await sut.cancellationInfo(tripNumber: TripCancellationInfo.sample.tripNumber)
        #expect(result.routeAlpha == TripCancellationInfo.sample.routeAlpha)
        #expect(result.direction == TripCancellationInfo.sample.direction)
        #expect(result.bookingId == TripCancellationInfo.sample.bookingId)
        #expect(result.canceled == TripCancellationInfo.sample.canceled)
        #expect(result.reinstated == TripCancellationInfo.sample.reinstated)
        #expect(result.tripNumber == TripCancellationInfo.sample.tripNumber)
        #expect(result.internalTripNumber == TripCancellationInfo.sample.internalTripNumber)
        #expect(result.tripStartTime == TripCancellationInfo.sample.tripStartTime)
        #expect(result.scheduleType == TripCancellationInfo.sample.scheduleType)
        #expect(result.nextTripNumber == TripCancellationInfo.sample.nextTripNumber)
        #expect(result.nextInternalTripNumber == TripCancellationInfo.sample.nextInternalTripNumber)
        #expect(result.nextTripStartTime == TripCancellationInfo.sample.nextTripStartTime)
        #expect(result.nextScheduleType == TripCancellationInfo.sample.nextScheduleType)
        #expect(result.prevTripNumber == TripCancellationInfo.sample.prevTripNumber)
        #expect(result.prevInternalTripNumber == TripCancellationInfo.sample.prevInternalTripNumber)
        #expect(result.prevTripStartTime == TripCancellationInfo.sample.prevTripStartTime)
        #expect(result.prevScheduleType == TripCancellationInfo.sample.prevScheduleType)
    }

    @Test("test .canceled() success case")
    func canceled() async throws {
        let jsonString = """
        [
            {
                "TripExceptionId": 12345,
                "EventType": "Canceled",
                "IncidentId": "INC-001",
                "IncidentUniqueId": 67890,
                "OpenDateTime": "2025-05-01T08:00:00.0000000-07:00",
                "IncidentAddDateTime": "2025-05-01T07:55:00.0000000-07:00",
                "TripStartTime": "2025-05-01T09:00:00.0000000-07:00",
                "RouteAlpha": "51A",
                "Direction": "NB",
                "TripNumber": 1001,
                "InternalTripNumber": 5001,
                "PatternId": 301,
                "FromStopId": "1234",
                "ToStopId": "5678",
                "FromStopDescription": "Main St & 1st Ave",
                "ToStopDescription": "Broadway & 5th Ave",
                "FromStopLatitude": 37.8044,
                "FromStopLongitude": -122.2711,
                "ToStopLatitude": 37.8102,
                "ToStopLongitude": -122.2705,
                "StopsInOrder": "1234,2345,3456,5678"
            }
        ]
        """
        setup(mockJSON: jsonString.data(using: .utf8))

        let result = try await sut.canceled()
        #expect(result.count == 1)
        #expect(result[0].tripExceptionId == TripException.sample.tripExceptionId)
        #expect(result[0].eventType == TripException.sample.eventType)
        #expect(result[0].incidentId == TripException.sample.incidentId)
        #expect(result[0].incidentUniqueId == TripException.sample.incidentUniqueId)
        #expect(result[0].openDateTime == TripException.sample.openDateTime)
        #expect(result[0].incidentAddDateTime == TripException.sample.incidentAddDateTime)
        #expect(result[0].tripStartTime == TripException.sample.tripStartTime)
        #expect(result[0].routeAlpha == TripException.sample.routeAlpha)
        #expect(result[0].direction == TripException.sample.direction)
        #expect(result[0].tripNumber == TripException.sample.tripNumber)
        #expect(result[0].internalTripNumber == TripException.sample.internalTripNumber)
        #expect(result[0].patternId == TripException.sample.patternId)
        #expect(result[0].fromStopId == TripException.sample.fromStopId)
        #expect(result[0].toStopId == TripException.sample.toStopId)
        #expect(result[0].fromStopDescription == TripException.sample.fromStopDescription)
        #expect(result[0].toStopDescription == TripException.sample.toStopDescription)
        #expect(result[0].fromStopLatitude == TripException.sample.fromStopLatitude)
        #expect(result[0].fromStopLongitude == TripException.sample.fromStopLongitude)
        #expect(result[0].toStopLatitude == TripException.sample.toStopLatitude)
        #expect(result[0].toStopLongitude == TripException.sample.toStopLongitude)
        #expect(result[0].stopsInOrder == TripException.sample.stopsInOrder)
    }
}

// MARK: - mocks

private struct MockRequestPerformer: RequestPerformable {
    var fixture: Data?

    func perform<T: Decodable & Sendable>(request: Request, decodeTo decodableObject: T.Type) async throws -> T {
        guard let fixture else {
            throw NSError(domain: "no fixture", code: -1)
        }
        return try JSONDecoder().decode(decodableObject, from: fixture)
    }
}

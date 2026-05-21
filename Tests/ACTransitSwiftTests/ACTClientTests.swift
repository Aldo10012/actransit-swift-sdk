@testable import ACTransitSwift
import EZNetworking
import Foundation
import Testing

@Suite("Test ACTClient")
final class ACTClientTests {
    private var sut: ACTClient

    init() {
        sut = ACTClient(performer: MockRequestPerformer())
    }

    deinit {
        self.sut = ACTClient(performer: MockRequestPerformer())
    }

    private func setup(mockJSON: Data?) {
        var performer = MockRequestPerformer()
        performer.fixture = mockJSON
        sut = ACTClient(performer: performer)
    }

    // MARK: - Tests

    @Test("test .getGtfs() success case")
    func getGtfs() async throws {
        let jsonString = """
        {
            "UpdatedDate": "2025-05-01T12:00:00.0000000-07:00",
            "EarliestServiceDate": "2025-04-28T00:00:00.0000000-07:00",
            "LatestServiceDate": "2025-08-31T00:00:00.0000000-07:00"
        }
        """
        setup(mockJSON: jsonString.data(using: .utf8))

        let result = try await sut.getGtfs()
        #expect(result.updatedDate == GtfsScheduleInfo.sample.updatedDate)
        #expect(result.earliestServiceDate == GtfsScheduleInfo.sample.earliestServiceDate)
        #expect(result.latestServiceDate == GtfsScheduleInfo.sample.latestServiceDate)
    }

    @Test("test .getGtfsAll() success case")
    func getGtfsAll() async throws {
        let jsonString = """
        [
            {
                "BookingId": "25FASU",
                "UpdatedDate": "2025-05-01T12:00:00.0000000-07:00",
                "EarliestServiceDate": "2025-04-28T00:00:00.0000000-07:00",
                "LatestServiceDate": "2025-08-31T00:00:00.0000000-07:00"
            }
        ]
        """
        setup(mockJSON: jsonString.data(using: .utf8))

        let result = try await sut.getGtfsAll()
        #expect(result.count == 1)
        #expect(result[0].bookingId == GtfsInfo.sample.bookingId)
        #expect(result[0].updatedDate == GtfsInfo.sample.updatedDate)
        #expect(result[0].earliestServiceDate == GtfsInfo.sample.earliestServiceDate)
        #expect(result[0].latestServiceDate == GtfsInfo.sample.latestServiceDate)
    }

    @Test("test .getTripsCanceled() success case")
    func getTripsCanceled() async throws {
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

        let result = try await sut.getTripsCanceled()
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

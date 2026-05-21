@testable import ACTransitSwift
import EZNetworking
import Foundation
import Testing

@Suite("Test ACTClient")
final class ACTClientTests {
    private var sut: ACTClient

    init() {
        self.sut = ACTClient(performer: MockRequestPerformer())
    }

    deinit {
        self.sut = ACTClient(performer: MockRequestPerformer())
    }

    private func setup(mockJSON: Data?) {
        var performer = MockRequestPerformer()
        performer.fixture = mockJSON
        self.sut = ACTClient(performer: performer)
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
}

// MARK: - mocks

private struct MockRequestPerformer: RequestPerformable {
    var fixture: Data? = nil

    func perform<T: Decodable & Sendable>(request: Request, decodeTo decodableObject: T.Type) async throws -> T {
        guard let fixture else {
            throw NSError(domain: "no fixture", code: -1)
        }
        return try JSONDecoder().decode(decodableObject, from: fixture)
    }
}

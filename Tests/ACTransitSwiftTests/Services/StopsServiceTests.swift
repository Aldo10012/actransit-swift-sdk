@testable import ACTransitSwift
import EZNetworking
import Foundation
import Testing

@Suite("Test StopsService")
final class StopsServiceTests {
    private var sut: StopsService

    init() {
        sut = StopsService(token: "mockToken", performer: MockRequestPerformer())
    }

    private func setup(mockJSON: Data?) {
        var performer = MockRequestPerformer()
        performer.fixture = mockJSON
        sut = StopsService(token: "mockToken", performer: performer)
    }

    // MARK: - Tests

    @Test("test .allStops() success case")
    func allStops() async throws {
        let jsonString = """
        [
            {
                "StopId": 55888,
                "Name": "Contra Costa College",
                "Latitude": 37.9710794,
                "Longitude": -122.3398753,
                "City": "Richmond",
                "ScheduledTime": "2026-05-23T05:10:00.000-07:00"
            }
        ]
        """
        setup(mockJSON: jsonString.data(using: .utf8))

        let result = try await sut.allStops()
        #expect(result.count == 1)
        #expect(result[0].stopId == Stop.sample.stopId)
        #expect(result[0].name == Stop.sample.name)
        #expect(result[0].latitude == Stop.sample.latitude)
        #expect(result[0].longitude == Stop.sample.longitude)
        #expect(result[0].city == Stop.sample.city)
    }

    @Test("test .summary() success case")
    func summary() async throws {
        let jsonString = """
        {
            "Count": 4850,
            "LastUpdatedDateTime": "2026-05-24T00:00:00.000-07:00"
        }
        """
        setup(mockJSON: jsonString.data(using: .utf8))

        let result = try await sut.summary()
        #expect(result.count == StopSummary.sample.count)
        #expect(result.lastUpdatedDateTime == StopSummary.sample.lastUpdatedDateTime)
    }

    @Test("test .nearbyByPath() success case")
    func nearbyByPath() async throws {
        let jsonString = """
        [
            {
                "StopId": 55888,
                "Name": "Contra Costa College",
                "Latitude": 37.9710794,
                "Longitude": -122.3398753,
                "City": "Richmond",
                "ScheduledTime": "2026-05-23T05:10:00.000-07:00"
            }
        ]
        """
        setup(mockJSON: jsonString.data(using: .utf8))

        let result = try await sut.nearbyByPath(latitude: 37.9710794, longitude: -122.3398753)
        #expect(result.count == 1)
        #expect(result[0].stopId == Stop.sample.stopId)
        #expect(result[0].name == Stop.sample.name)
    }

    @Test("test .nearby() success case")
    func nearby() async throws {
        let jsonString = """
        [
            {
                "StopId": 55888,
                "Name": "Contra Costa College",
                "Latitude": 37.9710794,
                "Longitude": -122.3398753,
                "City": "Richmond",
                "ScheduledTime": "2026-05-23T05:10:00.000-07:00"
            }
        ]
        """
        setup(mockJSON: jsonString.data(using: .utf8))

        let result = try await sut.nearby(latitude: 37.9710794, longitude: -122.3398753)
        #expect(result.count == 1)
        #expect(result[0].stopId == Stop.sample.stopId)
        #expect(result[0].name == Stop.sample.name)
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

@testable import ACTransitSwift
import EZNetworking
import Foundation
import Testing

@Suite("Test VehicleService")
final class VehicleServiceTests {
    private var sut: VehicleService

    init() {
        sut = VehicleService(token: "mockToken", performer: MockRequestPerformer())
    }

    private func setup(mockJSON: Data?) {
        var performer = MockRequestPerformer()
        performer.fixture = mockJSON
        sut = VehicleService(token: "mockToken", performer: performer)
    }

    // MARK: - Tests

    @Test("test .vehicle(vehicleId:) success case")
    func vehicle() async throws {
        let jsonString = """
        {
            "VehicleId": 1505,
            "CurrentTripId": 11862132,
            "Latitude": 37.8376083374023,
            "Longitude": -122.281852722168,
            "Heading": 350,
            "TimeLastReported": "2026-05-23T21:17:35"
        }
        """
        setup(mockJSON: jsonString.data(using: .utf8))

        let result = try await sut.vehicle(vehicleId: 1505)
        #expect(result.vehicleId == Vehicle.sample.vehicleId)
        #expect(result.currentTripId == Vehicle.sample.currentTripId)
        #expect(result.latitude == Vehicle.sample.latitude)
        #expect(result.longitude == Vehicle.sample.longitude)
        #expect(result.heading == Vehicle.sample.heading)
        #expect(result.timeLastReported == Vehicle.sample.timeLastReported)
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

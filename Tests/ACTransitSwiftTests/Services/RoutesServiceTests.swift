@testable import ACTransitSwift
import EZNetworking
import Foundation
import Testing

@Suite("Test RoutesService")
final class RoutesServiceTests {
    private var sut: RoutesService

    init() {
        sut = RoutesService(token: "mockToken", performer: MockRequestPerformer())
    }

    private func setup(mockJSON: Data?) {
        var performer = MockRequestPerformer()
        performer.fixture = mockJSON
        sut = RoutesService(token: "mockToken", performer: performer)
    }

    // MARK: - Tests

    @Test("test .trips() success case")
    func trips() async throws {
        let jsonString = """
        [
            {
                "TripId": 11861464,
                "RouteName": "72",
                "ScheduleType": 0,
                "StartTime": "2000-01-01T04:52:00",
                "Direction": "Southbound"
            }
        ]
        """
        setup(mockJSON: jsonString.data(using: .utf8))

        let result = try await sut.trips(routeName: Trip.sample.routeName)
        #expect(result.count == 1)
        #expect(result[0].tripId == Trip.sample.tripId)
        #expect(result[0].routeName == Trip.sample.routeName)
        #expect(result[0].scheduleType == Trip.sample.scheduleType)
        #expect(result[0].startTime == Trip.sample.startTime)
        #expect(result[0].direction == Trip.sample.direction)
    }

    @Test("test .route() success case")
    func route() async throws {
        let jsonString = """
        {
            "RouteId": "72",
            "Name": "72",
            "Description": "CCC - San Pablo"
        }
        """
        setup(mockJSON: jsonString.data(using: .utf8))

        let result = try await sut.route(routeName: Route.sample.routeId)
        #expect(result.routeId == Route.sample.routeId)
        #expect(result.name == Route.sample.name)
        #expect(result.description == Route.sample.description)
    }

    @Test("test .routes() success case")
    func routes() async throws {
        let jsonString = """
        [
            {
                "RouteId": "1T",
                "Name": "1T",
                "Division": "D4",
                "Description": "International - E. 14th",
                "IsLocal": true,
                "IsTransbay": false,
                "IsRapid": false,
                "IsAllNighter": false,
                "IsSchool": false
            }
        ]
        """
        setup(mockJSON: jsonString.data(using: .utf8))

        let result = try await sut.routes()
        #expect(result.count == 1)
        #expect(result[0].routeId == RouteDivision.sample.routeId)
        #expect(result[0].name == RouteDivision.sample.name)
        #expect(result[0].division == RouteDivision.sample.division)
        #expect(result[0].description == RouteDivision.sample.description)
        #expect(result[0].isLocal == RouteDivision.sample.isLocal)
        #expect(result[0].isTransbay == RouteDivision.sample.isTransbay)
        #expect(result[0].isRapid == RouteDivision.sample.isRapid)
        #expect(result[0].isAllNighter == RouteDivision.sample.isAllNighter)
        #expect(result[0].isSchool == RouteDivision.sample.isSchool)
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

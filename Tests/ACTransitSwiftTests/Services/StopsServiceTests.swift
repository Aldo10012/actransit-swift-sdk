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

    @Test("test .stopRoutes() success case")
    func stopRoutes() async throws {
        let jsonString = """
        ["72", "72R", "88"]
        """
        setup(mockJSON: jsonString.data(using: .utf8))

        let result = try await sut.stopRoutes(stopId: 55888)
        #expect(result.count == 3)
        #expect(result[0] == "72")
        #expect(result[1] == "72R")
        #expect(result[2] == "88")
    }

    @Test("test .tripsToday() success case")
    func tripsToday() async throws {
        let jsonString = """
        [
            {
                "RouteId": "72",
                "DirectionId": 0,
                "Direction": "Southbound",
                "ScheduleType": "Saturday",
                "Headsign": "Jack London Square",
                "Destination": "Jack London Square",
                "Destination2": "To Jack London Square",
                "TripStartTime": "2000-01-01T05:10:00",
                "TripId": 11862075,
                "TripNumber": 12324070,
                "TripNumber2": 11862075,
                "PositionNumber": 1,
                "StopId": 55888,
                "StopDescription": "Contra Costa College",
                "PassingTime": "2000-01-01T05:10:00",
                "StopNumber1": 4508,
                "StopNumber2": "1600410",
                "PlaceId": "CCCO",
                "StopLongitude": -122.3398753,
                "StopLatitude": 37.9710794
            }
        ]
        """
        setup(mockJSON: jsonString.data(using: .utf8))

        let result = try await sut.tripsToday(stopId: 55888)
        #expect(result.count == 1)
        #expect(result[0].routeId == TripStopToday.sample.routeId)
        #expect(result[0].stopId == TripStopToday.sample.stopId)
    }

    @Test("test .destinations() success case")
    func destinations() async throws {
        let jsonString = """
        {
            "StopId": 55888,
            "Status": "Active",
            "RouteDestinations": [
                {
                    "RouteId": "72",
                    "DirectionId": 0,
                    "Direction": "Southbound",
                    "Destination": "Jack London Square",
                    "FinalPassingTime": "2026-05-24T23:45:00",
                    "Status": "Active"
                }
            ]
        }
        """
        setup(mockJSON: jsonString.data(using: .utf8))

        let result = try await sut.destinations(stopId: 55888)
        #expect(result.stopId == StopDestination.sample.stopId)
        #expect(result.status == StopDestination.sample.status)
        #expect(result.routeDestinations.count == 1)
        #expect(result.routeDestinations[0].routeId == StopRouteDestination.sample.routeId)
    }

    @Test("test .profile() success case")
    func profile() async throws {
        let jsonString = """
        {
            "StopId": 55888,
            "Street": "Giant Rd",
            "City": "Richmond",
            "SiteDirection": "NW corner",
            "Site": "Giant Rd at Castro St",
            "Corner": "NW",
            "IsInService": true,
            "Latitude": 37.9710794,
            "Longitude": -122.3398753,
            "Routes": "72,72R",
            "AllowAlighting": true,
            "AllowBoarding": true,
            "PlaceId": "CCCO",
            "PlaceDescription": "Contra Costa College",
            "StopServiceAlerts": { "Url": "https://511.org/transit/alerts/55888" },
            "Amenities": { "Url": "https://511.org/transit/amenities/55888" },
            "Predictions": { "Url": "https://511.org/transit/real-time-arrivals?stopId=55888" },
            "Map": { "Url": "https://511.org/transit/stops/map/55888" },
            "Schedules": [
                { "RouteId": "72", "Url": "https://511.org/transit/schedules/72" }
            ]
        }
        """
        setup(mockJSON: jsonString.data(using: .utf8))

        let result = try await sut.profile(stopId: 55888)
        #expect(result.stopId == StopProfile.sample.stopId)
        #expect(result.city == StopProfile.sample.city)
        #expect(result.isInService == StopProfile.sample.isInService)
        #expect(result.routes == StopProfile.sample.routes)
        #expect(result.schedules.count == 1)
        #expect(result.schedules[0].routeId == RouteUrl.sample.routeId)
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

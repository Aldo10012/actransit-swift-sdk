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

    @Test("test .stops() success case")
    func stops() async throws {
        let jsonString = """
        [
            {
                "Route": "72",
                "Direction": "Northbound",
                "Destination": "To Contra Costa College",
                "Stops": [
                    {
                        "StopId": 51632,
                        "Name": "2nd St & Washington St",
                        "Latitude": 37.7965673,
                        "Longitude": -122.2778501,
                        "Order": 1
                    }
                ]
            }
        ]
        """
        setup(mockJSON: jsonString.data(using: .utf8))

        let result = try await sut.stops(routeName: RouteStopOrder.sample.route)
        #expect(result.count == 1)
        #expect(result[0].route == RouteStopOrder.sample.route)
        #expect(result[0].direction == RouteStopOrder.sample.direction)
        #expect(result[0].destination == RouteStopOrder.sample.destination)
        #expect(result[0].stops.count == 1)
        #expect(result[0].stops[0].stopId == StopOrder.sample.stopId)
        #expect(result[0].stops[0].name == StopOrder.sample.name)
    }

    @Test("test .directions() success case")
    func directions() async throws {
        let jsonString = """
        ["NORTH", "Northbound", "SOUTH", "Southbound"]
        """
        setup(mockJSON: jsonString.data(using: .utf8))

        let result = try await sut.directions(routeName: "72")
        #expect(result.count == 4)
        #expect(result[0] == "NORTH")
        #expect(result[1] == "Northbound")
    }

    @Test("test .tripsInstructions() success case")
    func tripsInstructions() async throws {
        let jsonString = """
        [
            {
                "TimePoints": null,
                "InstructionsText": "VIA CAMPUS DR, INTO MISSION BELL DR, R\\ COLLEGE LN, L\\ SAN PABLO AV",
                "TripId": 11861464,
                "RouteName": "72",
                "ScheduleType": 0,
                "StartTime": "2000-01-01T04:52:00",
                "Direction": "Southbound"
            }
        ]
        """
        setup(mockJSON: jsonString.data(using: .utf8))

        let result = try await sut.tripsInstructions(routeName: TripInstruction.sample.routeName, scheduleType: .weekday)
        #expect(result.count == 1)
        #expect(result[0].tripId == TripInstruction.sample.tripId)
        #expect(result[0].routeName == TripInstruction.sample.routeName)
        #expect(result[0].scheduleType == TripInstruction.sample.scheduleType)
        #expect(result[0].startTime == TripInstruction.sample.startTime)
        #expect(result[0].direction == TripInstruction.sample.direction)
        #expect(result[0].timePoints == nil)
    }

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

    @Test("test .vehicles() success case")
    func vehicles() async throws {
        let jsonString = """
        [
            {
                "VehicleId": 1505,
                "CurrentTripId": 11862132,
                "Latitude": 37.8376083374023,
                "Longitude": -122.281852722168,
                "Heading": 350,
                "TimeLastReported": "2026-05-23T21:17:35"
            }
        ]
        """
        setup(mockJSON: jsonString.data(using: .utf8))

        let result = try await sut.vehicles(routeName: "72")
        #expect(result.count == 1)
        #expect(result[0].vehicleId == Vehicle.sample.vehicleId)
        #expect(result[0].currentTripId == Vehicle.sample.currentTripId)
        #expect(result[0].latitude == Vehicle.sample.latitude)
        #expect(result[0].longitude == Vehicle.sample.longitude)
        #expect(result[0].heading == Vehicle.sample.heading)
        #expect(result[0].timeLastReported == Vehicle.sample.timeLastReported)
    }

    @Test("test .tripStops() success case")
    func tripStops() async throws {
        let jsonString = """
        [
            {
                "StopId": 55888,
                "Name": "Contra Costa College",
                "Latitude": 37.9710794,
                "Longitude": -122.3398753,
                "City": null,
                "ScheduledTime": null
            }
        ]
        """
        setup(mockJSON: jsonString.data(using: .utf8))

        let result = try await sut.tripStops(routeName: "72", tripId: TimePoint.sample.tripId)
        #expect(result.count == 1)
        #expect(result[0].stopId == Stop.sample.stopId)
        #expect(result[0].name == Stop.sample.name)
        #expect(result[0].latitude == Stop.sample.latitude)
        #expect(result[0].longitude == Stop.sample.longitude)
        #expect(result[0].city == nil)
        #expect(result[0].scheduledTime == nil)
    }

    @Test("test .pattern() success case")
    func pattern() async throws {
        let jsonString = """
        [
            {
                "TripId": 11861464,
                "Sequence": 1,
                "Latitude": 37.9554659,
                "Longitude": -122.3358682
            }
        ]
        """
        setup(mockJSON: jsonString.data(using: .utf8))

        let result = try await sut.pattern(routeName: "72", tripId: TimePoint.sample.tripId)
        #expect(result.count == 1)
        #expect(result[0].tripId == TimePoint.sample.tripId)
        #expect(result[0].sequence == TimePoint.sample.sequence)
        #expect(result[0].latitude == TimePoint.sample.latitude)
        #expect(result[0].longitude == TimePoint.sample.longitude)
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

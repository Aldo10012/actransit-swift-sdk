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

    @Test("test .schedule() success case")
    func schedule() async throws {
        let jsonString = """
        {
            "BookingId": "2604SP",
            "RouteProfiles": [
                {"RouteId": "72", "Profile": "Contra Costa College to Jack London Square via San Pablo Ave., El Cerrito del Norte BART, and Downtown Oakland."}
            ],
            "DateExceptions": [],
            "Stops": [
                {
                    "StopId": "55867",
                    "PlaceName": "San Pablo Ave. & Marin Ave.",
                    "PlaceId": "SPMA",
                    "StopDescription": "San Pablo Av & Marin Av (Albany City Hall)",
                    "Longitude": -122.2976044,
                    "Latitude": 37.886486,
                    "City": "Albany"
                }
            ],
            "Routes": [
                {
                    "RouteId": "72",
                    "LineDirection": "Northbound",
                    "LineDestination": "To Contra Costa College",
                    "DayCode": ["Weekday"],
                    "OperatingDOW": "Mondays through Fridays except holidays",
                    "Trips": [
                        {
                            "StartTime": "05:00:00",
                            "PatternId": "147",
                            "TripId": ["2305020"],
                            "Status": "OK",
                            "StopTimes": [
                                {"StopTime": "2026-05-23T05:00:00", "StopId": "51632", "PlaceId": "2NWN", "Occupancy": "Not Crowded"}
                            ]
                        }
                    ]
                }
            ]
        }
        """
        setup(mockJSON: jsonString.data(using: .utf8))

        let result = try await sut.schedule(routes: "72")
        #expect(result.bookingId == TripScheduleInfo.sample.bookingId)
        #expect(result.routeProfiles.count == 1)
        #expect(result.routeProfiles[0].routeId == RouteProfile.sample.routeId)
        #expect(result.stops.count == 1)
        #expect(result.stops[0].stopId == TripScheduleStop.sample.stopId)
        #expect(result.routes.count == 1)
        #expect(result.routes[0].trips.count == 1)
        #expect(result.routes[0].trips[0].startTime == TripScheduleTrip.sample.startTime)
        #expect(result.routes[0].trips[0].stopTimes[0].occupancy == TripScheduleStopTime.sample.occupancy)
    }

    @Test("test .timetable() success case")
    func timetable() async throws {
        let jsonString = """
        [
            {
                "BookingId": "2604SP",
                "RouteId": "72",
                "Destination": "To Jack London Square",
                "Direction": "Southbound",
                "DayCode": "Saturday",
                "Stops": [
                    {
                        "StopId": 55888,
                        "StopDescription": "Contra Costa College",
                        "PlaceId": "CCCO",
                        "StopLongitude": -122.3398753,
                        "StopLatitude": 37.9710794
                    }
                ],
                "Trips": [
                    {
                        "TripStartTime": "2026-05-23T05:10:00",
                        "TripId": 12324070,
                        "TripDestination": "Jack London Square",
                        "TripStops": [
                            {
                                "StopId": 55888,
                                "PassingTime": "2026-05-23T05:10:00"
                            }
                        ]
                    }
                ]
            }
        ]
        """
        setup(mockJSON: jsonString.data(using: .utf8))

        let result = try await sut.timetable(routes: "72", direction: "Southbound")
        #expect(result.count == 1)
        #expect(result[0].bookingId == TimeTable.sample.bookingId)
        #expect(result[0].routeId == TimeTable.sample.routeId)
        #expect(result[0].direction == TimeTable.sample.direction)
        #expect(result[0].stops.count == 1)
        #expect(result[0].stops[0].stopId == TimeTableStop.sample.stopId)
        #expect(result[0].trips.count == 1)
        #expect(result[0].trips[0].tripId == TimeTableTrip.sample.tripId)
        #expect(result[0].trips[0].tripStops.count == 1)
        #expect(result[0].trips[0].tripStops[0].passingTime == TimeTableTripStop.sample.passingTime)
    }

    @Test("test .tripStopsToday() success case")
    func tripStopsToday() async throws {
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

        let result = try await sut.tripStopsToday(routes: "72")
        #expect(result.count == 1)
        #expect(result[0].routeId == TripStopToday.sample.routeId)
        #expect(result[0].tripId == TripStopToday.sample.tripId)
        #expect(result[0].stopId == TripStopToday.sample.stopId)
        #expect(result[0].passingTime == TripStopToday.sample.passingTime)
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

        let result = try await sut.tripsToday(routes: "72")
        #expect(result.count == 1)
        #expect(result[0].routeId == TripStopToday.sample.routeId)
        #expect(result[0].directionId == TripStopToday.sample.directionId)
        #expect(result[0].tripId == TripStopToday.sample.tripId)
        #expect(result[0].tripStartTime == TripStopToday.sample.tripStartTime)
        #expect(result[0].passingTime == TripStopToday.sample.passingTime)
        #expect(result[0].stopId == TripStopToday.sample.stopId)
        #expect(result[0].placeId == TripStopToday.sample.placeId)
    }

    @Test("test .waypointsFast() success case")
    func waypointsFast() async throws {
        let jsonString = """
        [
            {
                "Booking": "2604SP",
                "RouteAlpha": "72",
                "Patterns": [
                    {
                        "DirectionId": 5,
                        "Direction": "NORTHBOUND",
                        "Destination": "To Contra Costa College",
                        "FirstPlaceId": "2NWN",
                        "LastPlaceId": "CCCO",
                        "IsDefault": true,
                        "TotalDistance": 74035,
                        "Waypoints": ["37.796567,-122.27785", "37.796486,-122.277406"]
                    }
                ]
            }
        ]
        """
        setup(mockJSON: jsonString.data(using: .utf8))

        let result = try await sut.waypointsFast(routes: "72")
        #expect(result.count == 1)
        #expect(result[0].booking == RouteWaypointsFast.sample.booking)
        #expect(result[0].routeAlpha == RouteWaypointsFast.sample.routeAlpha)
        #expect(result[0].patterns.count == 1)
        #expect(result[0].patterns[0].directionId == RoutePatternFast.sample.directionId)
        #expect(result[0].patterns[0].waypoints.count == 2)
        #expect(result[0].patterns[0].waypoints[0] == RoutePatternFast.sample.waypoints[0])
    }

    @Test("test .waypoints() success case")
    func waypoints() async throws {
        let jsonString = """
        [
            {
                "Booking": "2604SP",
                "RouteAlpha": "72",
                "Patterns": [
                    {
                        "DirectionId": 5,
                        "Direction": "NORTHBOUND",
                        "Destination": "To Contra Costa College",
                        "FirstPlaceId": "2NWN",
                        "LastPlaceId": "CCCO",
                        "IsDefault": true,
                        "TotalDistance": 74035,
                        "Waypoints": [
                            {
                                "OrderID": 0,
                                "Latitude": 37.796567,
                                "Longitude": -122.27785,
                                "Heading": 131.4,
                                "DistanceToNextStop": 723,
                                "DistanceFromStart": 0,
                                "StopSequence": 1
                            }
                        ]
                    }
                ]
            }
        ]
        """
        setup(mockJSON: jsonString.data(using: .utf8))

        let result = try await sut.waypoints(routes: "72")
        #expect(result.count == 1)
        #expect(result[0].booking == RouteWaypoints.sample.booking)
        #expect(result[0].routeAlpha == RouteWaypoints.sample.routeAlpha)
        #expect(result[0].patterns.count == 1)
        #expect(result[0].patterns[0].directionId == RoutePattern.sample.directionId)
        #expect(result[0].patterns[0].direction == RoutePattern.sample.direction)
        #expect(result[0].patterns[0].waypoints.count == 1)
        #expect(result[0].patterns[0].waypoints[0].orderId == RouteWaypoint.sample.orderId)
        #expect(result[0].patterns[0].waypoints[0].latitude == RouteWaypoint.sample.latitude)
    }

    @Test("test .tripEstimate() success case")
    func tripEstimate() async throws {
        let jsonString = """
        [
            {
                "RouteName": "72",
                "OriginStopId": 55888,
                "DestinationStopId": 51632,
                "ExpectedDepartureTime": "2026-05-23T21:35:00",
                "TripDuration": "01:05:00",
                "VehicleId": null
            }
        ]
        """
        setup(mockJSON: jsonString.data(using: .utf8))

        let result = try await sut.tripEstimate(routeName: "72", fromStopId: 55888, toStopId: 51632)
        #expect(result.count == 1)
        #expect(result[0].routeName == TripEstimate.sample.routeName)
        #expect(result[0].originStopId == TripEstimate.sample.originStopId)
        #expect(result[0].destinationStopId == TripEstimate.sample.destinationStopId)
        #expect(result[0].expectedDepartureTime == TripEstimate.sample.expectedDepartureTime)
        #expect(result[0].tripDuration == TripEstimate.sample.tripDuration)
        #expect(result[0].vehicleId == nil)
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

    @Test("test .destinations() success case")
    func destinations() async throws {
        let jsonString = """
        [
            {
                "RouteId": "72",
                "DirectionId": 0,
                "Direction": "Southbound",
                "Destination": "To Jack London Square"
            }
        ]
        """
        setup(mockJSON: jsonString.data(using: .utf8))

        let result = try await sut.destinations(routeName: "72")
        #expect(result.count == 1)
        #expect(result[0].routeId == RouteDestination.sample.routeId)
        #expect(result[0].directionId == RouteDestination.sample.directionId)
        #expect(result[0].direction == RouteDestination.sample.direction)
        #expect(result[0].destination == RouteDestination.sample.destination)
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

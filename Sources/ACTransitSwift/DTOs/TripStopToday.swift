import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=TripStopToday
public struct TripStopToday: Codable, Sendable {
    public let routeId: String
    public let directionId: Int
    public let direction: String
    /// String (e.g. "Saturday") rather than TripScheduleType because this endpoint returns text, not the integer raw value.
    public let scheduleType: String
    public let headsign: String
    public let destination: String
    public let destination2: String
    public let tripStartTime: String
    public let tripId: Int
    public let tripNumber: Int
    public let tripNumber2: Int
    public let positionNumber: Int
    public let stopId: Int
    public let stopDescription: String
    public let passingTime: String
    public let stopNumber1: Int
    public let stopNumber2: String
    public let placeId: String
    public let stopLongitude: Double
    public let stopLatitude: Double

    public init(
        routeId: String,
        directionId: Int,
        direction: String,
        scheduleType: String,
        headsign: String,
        destination: String,
        destination2: String,
        tripStartTime: String,
        tripId: Int,
        tripNumber: Int,
        tripNumber2: Int,
        positionNumber: Int,
        stopId: Int,
        stopDescription: String,
        passingTime: String,
        stopNumber1: Int,
        stopNumber2: String,
        placeId: String,
        stopLongitude: Double,
        stopLatitude: Double
    ) {
        self.routeId = routeId
        self.directionId = directionId
        self.direction = direction
        self.scheduleType = scheduleType
        self.headsign = headsign
        self.destination = destination
        self.destination2 = destination2
        self.tripStartTime = tripStartTime
        self.tripId = tripId
        self.tripNumber = tripNumber
        self.tripNumber2 = tripNumber2
        self.positionNumber = positionNumber
        self.stopId = stopId
        self.stopDescription = stopDescription
        self.passingTime = passingTime
        self.stopNumber1 = stopNumber1
        self.stopNumber2 = stopNumber2
        self.placeId = placeId
        self.stopLongitude = stopLongitude
        self.stopLatitude = stopLatitude
    }

    enum CodingKeys: String, CodingKey {
        case routeId = "RouteId"
        case directionId = "DirectionId"
        case direction = "Direction"
        case scheduleType = "ScheduleType"
        case headsign = "Headsign"
        case destination = "Destination"
        case destination2 = "Destination2"
        case tripStartTime = "TripStartTime"
        case tripId = "TripId"
        case tripNumber = "TripNumber"
        case tripNumber2 = "TripNumber2"
        case positionNumber = "PositionNumber"
        case stopId = "StopId"
        case stopDescription = "StopDescription"
        case passingTime = "PassingTime"
        case stopNumber1 = "StopNumber1"
        case stopNumber2 = "StopNumber2"
        case placeId = "PlaceId"
        case stopLongitude = "StopLongitude"
        case stopLatitude = "StopLatitude"
    }

    // MARK: - Mock Data

    public static let sample = TripStopToday(
        routeId: "72",
        directionId: 0,
        direction: "Southbound",
        scheduleType: "Saturday",
        headsign: "Jack London Square",
        destination: "Jack London Square",
        destination2: "To Jack London Square",
        tripStartTime: "2000-01-01T05:10:00",
        tripId: 11_862_075,
        tripNumber: 12_324_070,
        tripNumber2: 11_862_075,
        positionNumber: 1,
        stopId: 55888,
        stopDescription: "Contra Costa College",
        passingTime: "2000-01-01T05:10:00",
        stopNumber1: 4508,
        stopNumber2: "1600410",
        placeId: "CCCO",
        stopLongitude: -122.3398753,
        stopLatitude: 37.9710794
    )

    public static func make(
        routeId: String = sample.routeId,
        directionId: Int = sample.directionId,
        direction: String = sample.direction,
        scheduleType: String = sample.scheduleType,
        headsign: String = sample.headsign,
        destination: String = sample.destination,
        destination2: String = sample.destination2,
        tripStartTime: String = sample.tripStartTime,
        tripId: Int = sample.tripId,
        tripNumber: Int = sample.tripNumber,
        tripNumber2: Int = sample.tripNumber2,
        positionNumber: Int = sample.positionNumber,
        stopId: Int = sample.stopId,
        stopDescription: String = sample.stopDescription,
        passingTime: String = sample.passingTime,
        stopNumber1: Int = sample.stopNumber1,
        stopNumber2: String = sample.stopNumber2,
        placeId: String = sample.placeId,
        stopLongitude: Double = sample.stopLongitude,
        stopLatitude: Double = sample.stopLatitude
    ) -> TripStopToday {
        TripStopToday(
            routeId: routeId,
            directionId: directionId,
            direction: direction,
            scheduleType: scheduleType,
            headsign: headsign,
            destination: destination,
            destination2: destination2,
            tripStartTime: tripStartTime,
            tripId: tripId,
            tripNumber: tripNumber,
            tripNumber2: tripNumber2,
            positionNumber: positionNumber,
            stopId: stopId,
            stopDescription: stopDescription,
            passingTime: passingTime,
            stopNumber1: stopNumber1,
            stopNumber2: stopNumber2,
            placeId: placeId,
            stopLongitude: stopLongitude,
            stopLatitude: stopLatitude
        )
    }
}

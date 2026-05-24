import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=TimeTableTripStop
public struct TimeTableTripStop: Codable, Sendable {
    public let stopId: Int
    public let passingTime: String

    public init(stopId: Int, passingTime: String) {
        self.stopId = stopId
        self.passingTime = passingTime
    }

    enum CodingKeys: String, CodingKey {
        case stopId = "StopId"
        case passingTime = "PassingTime"
    }

    // MARK: - Mock Data

    public static let sample = TimeTableTripStop(
        stopId: 55888,
        passingTime: "2026-05-23T05:10:00"
    )

    public static func make(
        stopId: Int = sample.stopId,
        passingTime: String = sample.passingTime
    ) -> TimeTableTripStop {
        TimeTableTripStop(stopId: stopId, passingTime: passingTime)
    }
}

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=TimeTableTrip
public struct TimeTableTrip: Codable, Sendable {
    public let tripStartTime: String
    public let tripId: Int
    public let tripDestination: String
    public let tripStops: [TimeTableTripStop]

    public init(tripStartTime: String, tripId: Int, tripDestination: String, tripStops: [TimeTableTripStop]) {
        self.tripStartTime = tripStartTime
        self.tripId = tripId
        self.tripDestination = tripDestination
        self.tripStops = tripStops
    }

    enum CodingKeys: String, CodingKey {
        case tripStartTime = "TripStartTime"
        case tripId = "TripId"
        case tripDestination = "TripDestination"
        case tripStops = "TripStops"
    }

    // MARK: - Mock Data

    public static let sample = TimeTableTrip(
        tripStartTime: "2026-05-23T05:10:00",
        tripId: 12_324_070,
        tripDestination: "Jack London Square",
        tripStops: [TimeTableTripStop.sample]
    )

    public static func make(
        tripStartTime: String = sample.tripStartTime,
        tripId: Int = sample.tripId,
        tripDestination: String = sample.tripDestination,
        tripStops: [TimeTableTripStop] = sample.tripStops
    ) -> TimeTableTrip {
        TimeTableTrip(tripStartTime: tripStartTime, tripId: tripId, tripDestination: tripDestination, tripStops: tripStops)
    }
}

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=TimeTableStop
public struct TimeTableStop: Codable, Sendable {
    public let stopId: Int
    public let stopDescription: String
    public let placeId: String
    public let stopLongitude: Double
    public let stopLatitude: Double

    public init(stopId: Int, stopDescription: String, placeId: String, stopLongitude: Double, stopLatitude: Double) {
        self.stopId = stopId
        self.stopDescription = stopDescription
        self.placeId = placeId
        self.stopLongitude = stopLongitude
        self.stopLatitude = stopLatitude
    }

    enum CodingKeys: String, CodingKey {
        case stopId = "StopId"
        case stopDescription = "StopDescription"
        case placeId = "PlaceId"
        case stopLongitude = "StopLongitude"
        case stopLatitude = "StopLatitude"
    }

    // MARK: - Mock Data

    public static let sample = TimeTableStop(
        stopId: 55888,
        stopDescription: "Contra Costa College",
        placeId: "CCCO",
        stopLongitude: -122.3398753,
        stopLatitude: 37.9710794
    )

    public static func make(
        stopId: Int = sample.stopId,
        stopDescription: String = sample.stopDescription,
        placeId: String = sample.placeId,
        stopLongitude: Double = sample.stopLongitude,
        stopLatitude: Double = sample.stopLatitude
    ) -> TimeTableStop {
        TimeTableStop(stopId: stopId, stopDescription: stopDescription, placeId: placeId, stopLongitude: stopLongitude, stopLatitude: stopLatitude)
    }
}

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=TimeTable
public struct TimeTable: Codable, Sendable {
    public let bookingId: String
    public let routeId: String
    public let destination: String
    public let direction: String
    public let dayCode: String
    public let stops: [TimeTableStop]
    public let trips: [TimeTableTrip]

    public init(bookingId: String, routeId: String, destination: String, direction: String, dayCode: String, stops: [TimeTableStop], trips: [TimeTableTrip]) {
        self.bookingId = bookingId
        self.routeId = routeId
        self.destination = destination
        self.direction = direction
        self.dayCode = dayCode
        self.stops = stops
        self.trips = trips
    }

    enum CodingKeys: String, CodingKey {
        case bookingId = "BookingId"
        case routeId = "RouteId"
        case destination = "Destination"
        case direction = "Direction"
        case dayCode = "DayCode"
        case stops = "Stops"
        case trips = "Trips"
    }

    // MARK: - Mock Data

    public static let sample = TimeTable(
        bookingId: "2604SP",
        routeId: "72",
        destination: "To Jack London Square",
        direction: "Southbound",
        dayCode: "Saturday",
        stops: [TimeTableStop.sample],
        trips: [TimeTableTrip.sample]
    )

    public static func make(
        bookingId: String = sample.bookingId,
        routeId: String = sample.routeId,
        destination: String = sample.destination,
        direction: String = sample.direction,
        dayCode: String = sample.dayCode,
        stops: [TimeTableStop] = sample.stops,
        trips: [TimeTableTrip] = sample.trips
    ) -> TimeTable {
        TimeTable(bookingId: bookingId, routeId: routeId, destination: destination, direction: direction, dayCode: dayCode, stops: stops, trips: trips)
    }
}

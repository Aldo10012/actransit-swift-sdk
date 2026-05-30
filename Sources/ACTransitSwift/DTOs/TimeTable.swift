import Foundation

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

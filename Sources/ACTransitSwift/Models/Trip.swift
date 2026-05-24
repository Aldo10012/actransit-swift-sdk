import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=Trip
public struct Trip: Codable, Sendable {
    /// Identifier for the trip
    public let tripId: Int
    /// The route which this trip is currently running
    public let routeName: String
    /// The schedule for which this trip is being run (0 = Weekday, 5 = Saturday, 6 = Sunday)
    public let scheduleType: Int
    /// The scheduled start time for the trip. The date portion is always `2000-01-01`; only the time component is meaningful.
    public let startTime: String
    /// The direction the current trip is heading
    public let direction: String

    public init(tripId: Int, routeName: String, scheduleType: Int, startTime: String, direction: String) {
        self.tripId = tripId
        self.routeName = routeName
        self.scheduleType = scheduleType
        self.startTime = startTime
        self.direction = direction
    }

    enum CodingKeys: String, CodingKey {
        case tripId = "TripId"
        case routeName = "RouteName"
        case scheduleType = "ScheduleType"
        case startTime = "StartTime"
        case direction = "Direction"
    }

    // MARK: - Mock Data

    public static let sample = Trip(
        tripId: 11_861_464,
        routeName: "72",
        scheduleType: 0,
        startTime: "2000-01-01T04:52:00",
        direction: "Southbound"
    )

    public static func make(
        tripId: Int = sample.tripId,
        routeName: String = sample.routeName,
        scheduleType: Int = sample.scheduleType,
        startTime: String = sample.startTime,
        direction: String = sample.direction
    ) -> Trip {
        Trip(tripId: tripId, routeName: routeName, scheduleType: scheduleType, startTime: startTime, direction: direction)
    }
}

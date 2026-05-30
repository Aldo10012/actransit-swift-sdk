import Foundation

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

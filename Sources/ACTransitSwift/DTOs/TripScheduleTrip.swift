import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=TripScheduleTrip
public struct TripScheduleTrip: Codable, Sendable {
    /// Scheduled start time of a trip.
    public let startTime: String
    /// Unique identifier of the pattern for this trip.
    public let patternId: String
    /// Set of unique trip identifiers that are associated with the current data set.
    public let tripId: [String]
    /// Trip status. Values: `OK` or `Canceled`.
    public let status: String
    /// Collection of scheduled times for stops.
    public let stopTimes: [TripScheduleStopTime]

    public init(startTime: String, patternId: String, tripId: [String], status: String, stopTimes: [TripScheduleStopTime]) {
        self.startTime = startTime
        self.patternId = patternId
        self.tripId = tripId
        self.status = status
        self.stopTimes = stopTimes
    }

    enum CodingKeys: String, CodingKey {
        case startTime = "StartTime"
        case patternId = "PatternId"
        case tripId = "TripId"
        case status = "Status"
        case stopTimes = "StopTimes"
    }

    // MARK: - Mock Data

    public static let sample = TripScheduleTrip(
        startTime: "05:00:00",
        patternId: "147",
        tripId: ["2305020"],
        status: "OK",
        stopTimes: [TripScheduleStopTime.sample]
    )

    public static func make(
        startTime: String = sample.startTime,
        patternId: String = sample.patternId,
        tripId: [String] = sample.tripId,
        status: String = sample.status,
        stopTimes: [TripScheduleStopTime] = sample.stopTimes
    ) -> TripScheduleTrip {
        TripScheduleTrip(startTime: startTime, patternId: patternId, tripId: tripId, status: status, stopTimes: stopTimes)
    }
}

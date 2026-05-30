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

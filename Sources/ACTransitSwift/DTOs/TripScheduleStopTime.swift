import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=TripScheduleStopTime
public struct TripScheduleStopTime: Codable, Sendable {
    /// Scheduled passing time for this stop.
    public let stopTime: String
    /// Unique identifier (ID511) for this stop.
    public let stopId: String
    public let placeId: String
    /// Estimated vehicle crowding at a stop. Values: `Crowded`, `Some Crowding`, or `Not Crowded`.
    public let occupancy: String

    public init(stopTime: String, stopId: String, placeId: String, occupancy: String) {
        self.stopTime = stopTime
        self.stopId = stopId
        self.placeId = placeId
        self.occupancy = occupancy
    }

    enum CodingKeys: String, CodingKey {
        case stopTime = "StopTime"
        case stopId = "StopId"
        case placeId = "PlaceId"
        case occupancy = "Occupancy"
    }

    // MARK: - Mock Data

    public static let sample = TripScheduleStopTime(
        stopTime: "2026-05-23T05:00:00",
        stopId: "51632",
        placeId: "2NWN",
        occupancy: "Not Crowded"
    )

    public static func make(
        stopTime: String = sample.stopTime,
        stopId: String = sample.stopId,
        placeId: String = sample.placeId,
        occupancy: String = sample.occupancy
    ) -> TripScheduleStopTime {
        TripScheduleStopTime(stopTime: stopTime, stopId: stopId, placeId: placeId, occupancy: occupancy)
    }
}

import Foundation

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

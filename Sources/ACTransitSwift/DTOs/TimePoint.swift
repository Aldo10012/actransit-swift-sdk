import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=TimePoint
public struct TimePoint: Codable, Sendable {
    /// The Trip for which this timepoint and sequence are valid.
    public let tripId: Int
    /// The order this timepoint falls along the path for the given trip.
    public let sequence: Int
    public let latitude: Double
    public let longitude: Double

    public init(tripId: Int, sequence: Int, latitude: Double, longitude: Double) {
        self.tripId = tripId
        self.sequence = sequence
        self.latitude = latitude
        self.longitude = longitude
    }

    enum CodingKeys: String, CodingKey {
        case tripId = "TripId"
        case sequence = "Sequence"
        case latitude = "Latitude"
        case longitude = "Longitude"
    }

    // MARK: - Mock Data

    public static let sample = TimePoint(
        tripId: 11_861_464,
        sequence: 1,
        latitude: 37.9554659,
        longitude: -122.3358682
    )

    public static func make(
        tripId: Int = sample.tripId,
        sequence: Int = sample.sequence,
        latitude: Double = sample.latitude,
        longitude: Double = sample.longitude
    ) -> TimePoint {
        TimePoint(tripId: tripId, sequence: sequence, latitude: latitude, longitude: longitude)
    }
}

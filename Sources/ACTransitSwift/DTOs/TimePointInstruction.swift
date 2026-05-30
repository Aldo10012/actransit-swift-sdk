import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=TimePointInstruction
public struct TimePointInstruction: Codable, Sendable {
    /// The instruction to take at a time point on a trip.
    public let instruction: String
    /// The Trip for which this timepoint and sequence are valid.
    public let tripId: Int
    /// The order this timepoint falls along the path for the given trip.
    public let sequence: Int
    public let latitude: Double
    public let longitude: Double

    public init(instruction: String, tripId: Int, sequence: Int, latitude: Double, longitude: Double) {
        self.instruction = instruction
        self.tripId = tripId
        self.sequence = sequence
        self.latitude = latitude
        self.longitude = longitude
    }

    enum CodingKeys: String, CodingKey {
        case instruction = "Instruction"
        case tripId = "TripId"
        case sequence = "Sequence"
        case latitude = "Latitude"
        case longitude = "Longitude"
    }

    // MARK: - Mock Data

    public static let sample = TimePointInstruction(
        instruction: "L\\ SAN PABLO AV",
        tripId: 11_861_464,
        sequence: 1,
        latitude: 37.9135,
        longitude: -122.3022
    )

    public static func make(
        instruction: String = sample.instruction,
        tripId: Int = sample.tripId,
        sequence: Int = sample.sequence,
        latitude: Double = sample.latitude,
        longitude: Double = sample.longitude
    ) -> TimePointInstruction {
        TimePointInstruction(instruction: instruction, tripId: tripId, sequence: sequence, latitude: latitude, longitude: longitude)
    }
}

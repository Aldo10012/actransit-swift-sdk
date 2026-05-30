import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=Direction
public struct ActRealtimeDirection: Codable, Sendable {
    /// The direction designator used in other requests such as getpredictions.
    public let id: String
    /// The human-readable, locale-dependent name of the direction.
    public let name: String

    public init(id: String, name: String) {
        self.id = id
        self.name = name
    }

    // MARK: - Mock Data

    public static let sample = ActRealtimeDirection(id: "TO DOWNTOWN BERKELEY", name: "TO DOWNTOWN BERKELEY")

    public static func make(
        id: String = sample.id,
        name: String = sample.name
    ) -> ActRealtimeDirection {
        ActRealtimeDirection(id: id, name: name)
    }
}

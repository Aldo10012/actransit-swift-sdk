import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=RtDir
public struct RtDir: Codable, Sendable {
    /// Alphanumeric designator of a route.
    public let rt: String
    /// Direction identifier.
    public let dir: String

    public init(rt: String, dir: String) {
        self.rt = rt
        self.dir = dir
    }

    // MARK: - Mock Data

    public static let sample = RtDir(rt: "51A", dir: "TO DOWNTOWN BERKELEY")

    public static func make(
        rt: String = sample.rt,
        dir: String = sample.dir
    ) -> RtDir {
        RtDir(rt: rt, dir: dir)
    }
}

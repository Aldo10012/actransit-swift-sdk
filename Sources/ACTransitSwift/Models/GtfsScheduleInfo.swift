import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=GtfsScheduleInfo
public struct GtfsScheduleInfo: Codable, Sendable {
    /// The date the GTFS cchedule data was last updated.
    public let updatedDate: Date
    /// The first date serviced by the current schedule
    public let earliestServiceDate: Date
    /// The last date seviced by the current schedule
    public let latestServiceDate: Date

    public init(updatedDate: Date, earliestServiceDate: Date, latestServiceDate: Date) {
        self.updatedDate = updatedDate
        self.earliestServiceDate = earliestServiceDate
        self.latestServiceDate = latestServiceDate
    }

    enum CodingKeys: String, CodingKey {
        case updatedDate = "UpdatedDate"
        case earliestServiceDate = "EarliestServiceDate"
        case latestServiceDate = "LatestServiceDate"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        updatedDate = try Self.parseDate(container.decode(String.self, forKey: .updatedDate), key: "UpdatedDate")
        earliestServiceDate = try Self.parseDate(container.decode(String.self, forKey: .earliestServiceDate), key: "EarliestServiceDate")
        latestServiceDate = try Self.parseDate(container.decode(String.self, forKey: .latestServiceDate), key: "LatestServiceDate")
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(Self.iso8601.string(from: updatedDate), forKey: .updatedDate)
        try container.encode(Self.iso8601.string(from: earliestServiceDate), forKey: .earliestServiceDate)
        try container.encode(Self.iso8601.string(from: latestServiceDate), forKey: .latestServiceDate)
    }

    // The API returns up to 7 fractional-second digits; normalize to 3 before parsing.
    private static func parseDate(_ string: String, key: String) throws -> Date {
        let normalized = string.replacingOccurrences(
            of: #"(\.\d{3})\d+"#,
            with: "$1",
            options: .regularExpression
        )
        guard let date = iso8601.date(from: normalized) else {
            throw DecodingError.dataCorrupted(
                .init(codingPath: [], debugDescription: "Cannot parse date '\(string)' for key '\(key)'")
            )
        }
        return date
    }

    private nonisolated(unsafe) static let iso8601: ISO8601DateFormatter = {
        let f = ISO8601DateFormatter()
        f.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return f
    }()

    // MARK: - Mock Data

    public static let sample: GtfsScheduleInfo = {
        let f = ISO8601DateFormatter()
        return GtfsScheduleInfo(
            updatedDate: f.date(from: "2025-05-01T12:00:00-07:00")!,
            earliestServiceDate: f.date(from: "2025-04-28T00:00:00-07:00")!,
            latestServiceDate: f.date(from: "2025-08-31T00:00:00-07:00")!
        )
    }()

    public static let minimal = GtfsScheduleInfo(
        updatedDate: .distantPast,
        earliestServiceDate: .distantPast,
        latestServiceDate: .distantPast
    )

    public static func make(
        updatedDate: Date = sample.updatedDate,
        earliestServiceDate: Date = sample.earliestServiceDate,
        latestServiceDate: Date = sample.latestServiceDate
    ) -> GtfsScheduleInfo {
        GtfsScheduleInfo(updatedDate: updatedDate, earliestServiceDate: earliestServiceDate, latestServiceDate: latestServiceDate)
    }
}

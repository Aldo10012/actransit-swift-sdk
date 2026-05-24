import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=StopSummary
public struct StopSummary: Codable, Sendable {
    /// Number of stops in current list
    public let count: Int
    /// Last date/time stop information was changed
    public let lastUpdatedDateTime: Date

    public init(count: Int, lastUpdatedDateTime: Date) {
        self.count = count
        self.lastUpdatedDateTime = lastUpdatedDateTime
    }

    enum CodingKeys: String, CodingKey {
        case count = "Count"
        case lastUpdatedDateTime = "LastUpdatedDateTime"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        count = try container.decode(Int.self, forKey: .count)
        lastUpdatedDateTime = try Self.parseDate(
            container.decode(String.self, forKey: .lastUpdatedDateTime),
            key: "LastUpdatedDateTime"
        )
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(count, forKey: .count)
        try container.encode(ISO8601DateFormatter.ACTFormat.string(from: lastUpdatedDateTime), forKey: .lastUpdatedDateTime)
    }

    // The API returns up to 7 fractional-second digits; normalize to 3 before parsing.
    private static func parseDate(_ string: String, key: String) throws -> Date {
        let normalized = string.replacingOccurrences(
            of: #"(\.\d{3})\d+"#,
            with: "$1",
            options: .regularExpression
        )
        guard let date = ISO8601DateFormatter.ACTFormat.date(from: normalized) else {
            throw DecodingError.dataCorrupted(
                .init(codingPath: [], debugDescription: "Cannot parse date '\(string)' for key '\(key)'")
            )
        }
        return date
    }

    // MARK: - Mock Data

    public static let sample = StopSummary(
        count: 4850,
        lastUpdatedDateTime: ISO8601DateFormatter.ACTFormat.date(from: "2026-05-24T00:00:00.000-07:00")!
    )

    public static func make(
        count: Int = sample.count,
        lastUpdatedDateTime: Date = sample.lastUpdatedDateTime
    ) -> StopSummary {
        StopSummary(count: count, lastUpdatedDateTime: lastUpdatedDateTime)
    }
}

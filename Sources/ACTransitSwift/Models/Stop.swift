import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=Stop
public struct Stop: Codable, Sendable {
    public let stopId: Int
    public let name: String
    public let latitude: Double
    public let longitude: Double
    public let city: String?
    /// The time a vehicle is scheduled to depart from this stop. Note: The 'date' part of this variable is unimportant, use only the Time.
    public let scheduledTime: Date?

    public init(stopId: Int, name: String, latitude: Double, longitude: Double, city: String?, scheduledTime: Date?) {
        self.stopId = stopId
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.city = city
        self.scheduledTime = scheduledTime
    }

    enum CodingKeys: String, CodingKey {
        case stopId = "StopId"
        case name = "Name"
        case latitude = "Latitude"
        case longitude = "Longitude"
        case city = "City"
        case scheduledTime = "ScheduledTime"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        stopId = try container.decode(Int.self, forKey: .stopId)
        name = try container.decode(String.self, forKey: .name)
        latitude = try container.decode(Double.self, forKey: .latitude)
        longitude = try container.decode(Double.self, forKey: .longitude)
        city = try container.decodeIfPresent(String.self, forKey: .city)
        if let rawDate = try container.decodeIfPresent(String.self, forKey: .scheduledTime) {
            scheduledTime = try Self.parseDate(rawDate, key: "ScheduledTime")
        } else {
            scheduledTime = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(stopId, forKey: .stopId)
        try container.encode(name, forKey: .name)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
        try container.encodeIfPresent(city, forKey: .city)
        if let scheduledTime {
            try container.encode(ISO8601DateFormatter.ACTFormat.string(from: scheduledTime), forKey: .scheduledTime)
        } else {
            try container.encodeNil(forKey: .scheduledTime)
        }
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

    public static let sample = Stop(
        stopId: 55888,
        name: "Contra Costa College",
        latitude: 37.9710794,
        longitude: -122.3398753,
        city: "Richmond",
        scheduledTime: ISO8601DateFormatter.ACTFormat.date(from: "2026-05-23T05:10:00.000-07:00")!
    )

    public static let minimal = Stop(
        stopId: 55888,
        name: "Contra Costa College",
        latitude: 37.9710794,
        longitude: -122.3398753,
        city: nil,
        scheduledTime: nil
    )

    public static func make(
        stopId: Int = sample.stopId,
        name: String = sample.name,
        latitude: Double = sample.latitude,
        longitude: Double = sample.longitude,
        city: String? = sample.city,
        scheduledTime: Date? = sample.scheduledTime
    ) -> Stop {
        Stop(stopId: stopId, name: name, latitude: latitude, longitude: longitude, city: city, scheduledTime: scheduledTime)
    }
}

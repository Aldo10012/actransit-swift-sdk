import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=VehicleRealtimeAttributes
public struct VehicleRealtimeAttributes: Codable, Sendable {
    /// Alphanumeric string representing the vehicle ID (ie. bus number).
    public let vehicleId: String
    /// Name of the route that the vehicle is currently servicing.
    public let currentRoute: String
    /// Last known latitude position in Decimal Degrees. Null if unavailable.
    public let lastPositionLatitude: Double?
    /// Last known longitude position in Decimal Degrees. Null if unavailable.
    public let lastPositionLongitude: Double?
    /// Datetime indicating when the vehicle position was last reported (PST/PDT). Null if unavailable.
    public let dateTimePositionReported: Date?
    /// Numeric value that represents the vehicle's maximum recommended passenger load. Null if unavailable.
    public let vehicleCapacity: Int?
    /// Integer value that represents the vehicle's current passenger count. Null if unavailable.
    public let currentPassengerCount: Int?
    /// Integer value that represents the vehicle's estimated occupancy percentage. Null if unavailable.
    public let estimatedOccupancyPercentage: Int?
    /// RGB color in hexadecimal format representing current occupancy status. Null if unavailable.
    public let estimatedOccupancyStatusColor: String?
    /// Occupancy status descriptor: Null, Not Crowded, Some Crowding, or Crowded.
    public let estimatedOccupancyStatus: String?
    /// Datetime indicating when passenger occupancy status was last reported (PST/PDT). Null if unavailable.
    public let dateTimeAPCReported: Date?

    public init(
        vehicleId: String,
        currentRoute: String,
        lastPositionLatitude: Double?,
        lastPositionLongitude: Double?,
        dateTimePositionReported: Date?,
        vehicleCapacity: Int?,
        currentPassengerCount: Int?,
        estimatedOccupancyPercentage: Int?,
        estimatedOccupancyStatusColor: String?,
        estimatedOccupancyStatus: String?,
        dateTimeAPCReported: Date?
    ) {
        self.vehicleId = vehicleId
        self.currentRoute = currentRoute
        self.lastPositionLatitude = lastPositionLatitude
        self.lastPositionLongitude = lastPositionLongitude
        self.dateTimePositionReported = dateTimePositionReported
        self.vehicleCapacity = vehicleCapacity
        self.currentPassengerCount = currentPassengerCount
        self.estimatedOccupancyPercentage = estimatedOccupancyPercentage
        self.estimatedOccupancyStatusColor = estimatedOccupancyStatusColor
        self.estimatedOccupancyStatus = estimatedOccupancyStatus
        self.dateTimeAPCReported = dateTimeAPCReported
    }

    enum CodingKeys: String, CodingKey {
        case vehicleId = "VehicleId"
        case currentRoute = "CurrentRoute"
        case lastPositionLatitude = "LastPositionLatitude"
        case lastPositionLongitude = "LastPositionLongitude"
        case dateTimePositionReported = "DateTimePositionReported"
        case vehicleCapacity = "VehicleCapacity"
        case currentPassengerCount = "CurrentPassengerCount"
        case estimatedOccupancyPercentage = "EstimatedOccupancyPercentage"
        case estimatedOccupancyStatusColor = "EstimatedOccupancyStatusColor"
        case estimatedOccupancyStatus = "EstimatedOccupancyStatus"
        case dateTimeAPCReported = "DateTimeAPCReported"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        vehicleId = try container.decode(String.self, forKey: .vehicleId)
        currentRoute = try container.decode(String.self, forKey: .currentRoute)
        lastPositionLatitude = try container.decodeIfPresent(Double.self, forKey: .lastPositionLatitude)
        lastPositionLongitude = try container.decodeIfPresent(Double.self, forKey: .lastPositionLongitude)
        if let rawDate = try container.decodeIfPresent(String.self, forKey: .dateTimePositionReported) {
            dateTimePositionReported = try Self.parseDate(rawDate, key: "DateTimePositionReported")
        } else {
            dateTimePositionReported = nil
        }
        vehicleCapacity = try container.decodeIfPresent(Int.self, forKey: .vehicleCapacity)
        currentPassengerCount = try container.decodeIfPresent(Int.self, forKey: .currentPassengerCount)
        estimatedOccupancyPercentage = try container.decodeIfPresent(Int.self, forKey: .estimatedOccupancyPercentage)
        estimatedOccupancyStatusColor = try container.decodeIfPresent(String.self, forKey: .estimatedOccupancyStatusColor)
        estimatedOccupancyStatus = try container.decodeIfPresent(String.self, forKey: .estimatedOccupancyStatus)
        if let rawDate = try container.decodeIfPresent(String.self, forKey: .dateTimeAPCReported) {
            dateTimeAPCReported = try Self.parseDate(rawDate, key: "DateTimeAPCReported")
        } else {
            dateTimeAPCReported = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(vehicleId, forKey: .vehicleId)
        try container.encode(currentRoute, forKey: .currentRoute)
        try container.encodeIfPresent(lastPositionLatitude, forKey: .lastPositionLatitude)
        try container.encodeIfPresent(lastPositionLongitude, forKey: .lastPositionLongitude)
        if let dateTimePositionReported {
            try container.encode(ISO8601DateFormatter.ACTFormat.string(from: dateTimePositionReported), forKey: .dateTimePositionReported)
        } else {
            try container.encodeNil(forKey: .dateTimePositionReported)
        }
        try container.encodeIfPresent(vehicleCapacity, forKey: .vehicleCapacity)
        try container.encodeIfPresent(currentPassengerCount, forKey: .currentPassengerCount)
        try container.encodeIfPresent(estimatedOccupancyPercentage, forKey: .estimatedOccupancyPercentage)
        try container.encodeIfPresent(estimatedOccupancyStatusColor, forKey: .estimatedOccupancyStatusColor)
        try container.encodeIfPresent(estimatedOccupancyStatus, forKey: .estimatedOccupancyStatus)
        if let dateTimeAPCReported {
            try container.encode(ISO8601DateFormatter.ACTFormat.string(from: dateTimeAPCReported), forKey: .dateTimeAPCReported)
        } else {
            try container.encodeNil(forKey: .dateTimeAPCReported)
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

    public static let sample = VehicleRealtimeAttributes(
        vehicleId: "1505",
        currentRoute: "51A",
        lastPositionLatitude: 37.8376083374023,
        lastPositionLongitude: -122.281852722168,
        dateTimePositionReported: ISO8601DateFormatter.ACTQueryFormat.date(from: "2026-05-23T21:17:35-07:00")!,
        vehicleCapacity: 60,
        currentPassengerCount: 25,
        estimatedOccupancyPercentage: 42,
        estimatedOccupancyStatusColor: "#00CC00",
        estimatedOccupancyStatus: "Not Crowded",
        dateTimeAPCReported: ISO8601DateFormatter.ACTQueryFormat.date(from: "2026-05-23T21:17:35-07:00")!
    )

    public static let minimal = VehicleRealtimeAttributes(
        vehicleId: "1505",
        currentRoute: "51A",
        lastPositionLatitude: nil,
        lastPositionLongitude: nil,
        dateTimePositionReported: nil,
        vehicleCapacity: nil,
        currentPassengerCount: nil,
        estimatedOccupancyPercentage: nil,
        estimatedOccupancyStatusColor: nil,
        estimatedOccupancyStatus: nil,
        dateTimeAPCReported: nil
    )

    public static func make(
        vehicleId: String = sample.vehicleId,
        currentRoute: String = sample.currentRoute,
        lastPositionLatitude: Double? = sample.lastPositionLatitude,
        lastPositionLongitude: Double? = sample.lastPositionLongitude,
        dateTimePositionReported: Date? = sample.dateTimePositionReported,
        vehicleCapacity: Int? = sample.vehicleCapacity,
        currentPassengerCount: Int? = sample.currentPassengerCount,
        estimatedOccupancyPercentage: Int? = sample.estimatedOccupancyPercentage,
        estimatedOccupancyStatusColor: String? = sample.estimatedOccupancyStatusColor,
        estimatedOccupancyStatus: String? = sample.estimatedOccupancyStatus,
        dateTimeAPCReported: Date? = sample.dateTimeAPCReported
    ) -> VehicleRealtimeAttributes {
        VehicleRealtimeAttributes(
            vehicleId: vehicleId,
            currentRoute: currentRoute,
            lastPositionLatitude: lastPositionLatitude,
            lastPositionLongitude: lastPositionLongitude,
            dateTimePositionReported: dateTimePositionReported,
            vehicleCapacity: vehicleCapacity,
            currentPassengerCount: currentPassengerCount,
            estimatedOccupancyPercentage: estimatedOccupancyPercentage,
            estimatedOccupancyStatusColor: estimatedOccupancyStatusColor,
            estimatedOccupancyStatus: estimatedOccupancyStatus,
            dateTimeAPCReported: dateTimeAPCReported
        )
    }
}

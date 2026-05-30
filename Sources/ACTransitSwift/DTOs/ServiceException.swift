import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=ServiceException
public struct ServiceException: Codable, Sendable {
    /// Unique identier that represents this service exception.
    public let exceptionCode: String
    /// Pattern unique identifer for the current service exception.
    public let patternId: String
    /// Trip unique identifier for the current service exception.
    public let tripId: [String]
    /// String that represents the days that this route is normally serviced.
    public let operatingDays: String
    /// Collection of dates when this route will not be serviced.
    public let exceptionDates: [String]
    /// Collection of strings that contain, in natural language, service exceptions for a trip.
    public let exceptionNotices: [String]

    public init(exceptionCode: String, patternId: String, tripId: [String], operatingDays: String, exceptionDates: [String], exceptionNotices: [String]) {
        self.exceptionCode = exceptionCode
        self.patternId = patternId
        self.tripId = tripId
        self.operatingDays = operatingDays
        self.exceptionDates = exceptionDates
        self.exceptionNotices = exceptionNotices
    }

    enum CodingKeys: String, CodingKey {
        case exceptionCode = "ExceptionCode"
        case patternId = "PatternId"
        case tripId = "TripId"
        case operatingDays = "OperatingDays"
        case exceptionDates = "ExceptionDates"
        case exceptionNotices = "ExceptionNotices"
    }

    // MARK: - Mock Data

    public static let sample = ServiceException(
        exceptionCode: "EX001",
        patternId: "147",
        tripId: ["2305020"],
        operatingDays: "Mondays through Fridays except holidays",
        exceptionDates: ["2026-05-26"],
        exceptionNotices: ["No service on Memorial Day"]
    )

    public static func make(
        exceptionCode: String = sample.exceptionCode,
        patternId: String = sample.patternId,
        tripId: [String] = sample.tripId,
        operatingDays: String = sample.operatingDays,
        exceptionDates: [String] = sample.exceptionDates,
        exceptionNotices: [String] = sample.exceptionNotices
    ) -> ServiceException {
        ServiceException(exceptionCode: exceptionCode, patternId: patternId, tripId: tripId, operatingDays: operatingDays, exceptionDates: exceptionDates, exceptionNotices: exceptionNotices)
    }
}

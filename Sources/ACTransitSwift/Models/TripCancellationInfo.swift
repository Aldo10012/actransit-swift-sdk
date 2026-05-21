import Foundation

/// https://api.actransit.org/transit/Help/Api/GET-trips-tripcancellationinfo-tripNumber
public struct TripCancellationInfo: Codable, Sendable {
    public let routeAlpha: String
    public let direction: String
    public let bookingId: String
    public let canceled: Bool
    public let reinstated: Bool
    public let tripNumber: Int
    public let internalTripNumber: Int
    public let tripStartTime: Date
    public let scheduleType: String
    public let nextTripNumber: Int
    public let nextInternalTripNumber: Int
    public let nextTripStartTime: Date
    public let nextScheduleType: String
    public let prevTripNumber: Int
    public let prevInternalTripNumber: Int
    public let prevTripStartTime: Date
    public let prevScheduleType: String

    public init(
        routeAlpha: String,
        direction: String,
        bookingId: String,
        canceled: Bool,
        reinstated: Bool,
        tripNumber: Int,
        internalTripNumber: Int,
        tripStartTime: Date,
        scheduleType: String,
        nextTripNumber: Int,
        nextInternalTripNumber: Int,
        nextTripStartTime: Date,
        nextScheduleType: String,
        prevTripNumber: Int,
        prevInternalTripNumber: Int,
        prevTripStartTime: Date,
        prevScheduleType: String
    ) {
        self.routeAlpha = routeAlpha
        self.direction = direction
        self.bookingId = bookingId
        self.canceled = canceled
        self.reinstated = reinstated
        self.tripNumber = tripNumber
        self.internalTripNumber = internalTripNumber
        self.tripStartTime = tripStartTime
        self.scheduleType = scheduleType
        self.nextTripNumber = nextTripNumber
        self.nextInternalTripNumber = nextInternalTripNumber
        self.nextTripStartTime = nextTripStartTime
        self.nextScheduleType = nextScheduleType
        self.prevTripNumber = prevTripNumber
        self.prevInternalTripNumber = prevInternalTripNumber
        self.prevTripStartTime = prevTripStartTime
        self.prevScheduleType = prevScheduleType
    }

    enum CodingKeys: String, CodingKey {
        case routeAlpha = "RouteAlpha"
        case direction = "Direction"
        case bookingId = "BookingId"
        case canceled = "Canceled"
        case reinstated = "Reinstated"
        case tripNumber = "TripNumber"
        case internalTripNumber = "InternalTripNumber"
        case tripStartTime = "TripStartTime"
        case scheduleType = "ScheduleType"
        case nextTripNumber = "NextTripNumber"
        case nextInternalTripNumber = "NextInternalTripNumber"
        case nextTripStartTime = "NextTripStartTime"
        case nextScheduleType = "NextScheduleType"
        case prevTripNumber = "PrevTripNumber"
        case prevInternalTripNumber = "PrevInternalTripNumber"
        case prevTripStartTime = "PrevTripStartTime"
        case prevScheduleType = "PrevScheduleType"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        routeAlpha = try container.decode(String.self, forKey: .routeAlpha)
        direction = try container.decode(String.self, forKey: .direction)
        bookingId = try container.decode(String.self, forKey: .bookingId)
        canceled = try container.decode(Bool.self, forKey: .canceled)
        reinstated = try container.decode(Bool.self, forKey: .reinstated)
        tripNumber = try container.decode(Int.self, forKey: .tripNumber)
        internalTripNumber = try container.decode(Int.self, forKey: .internalTripNumber)
        tripStartTime = try Self.parseDate(container.decode(String.self, forKey: .tripStartTime), key: "TripStartTime")
        scheduleType = try container.decode(String.self, forKey: .scheduleType)
        nextTripNumber = try container.decode(Int.self, forKey: .nextTripNumber)
        nextInternalTripNumber = try container.decode(Int.self, forKey: .nextInternalTripNumber)
        nextTripStartTime = try Self.parseDate(container.decode(String.self, forKey: .nextTripStartTime), key: "NextTripStartTime")
        nextScheduleType = try container.decode(String.self, forKey: .nextScheduleType)
        prevTripNumber = try container.decode(Int.self, forKey: .prevTripNumber)
        prevInternalTripNumber = try container.decode(Int.self, forKey: .prevInternalTripNumber)
        prevTripStartTime = try Self.parseDate(container.decode(String.self, forKey: .prevTripStartTime), key: "PrevTripStartTime")
        prevScheduleType = try container.decode(String.self, forKey: .prevScheduleType)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(routeAlpha, forKey: .routeAlpha)
        try container.encode(direction, forKey: .direction)
        try container.encode(bookingId, forKey: .bookingId)
        try container.encode(canceled, forKey: .canceled)
        try container.encode(reinstated, forKey: .reinstated)
        try container.encode(tripNumber, forKey: .tripNumber)
        try container.encode(internalTripNumber, forKey: .internalTripNumber)
        try container.encode(ISO8601DateFormatter.ACTFormat.string(from: tripStartTime), forKey: .tripStartTime)
        try container.encode(scheduleType, forKey: .scheduleType)
        try container.encode(nextTripNumber, forKey: .nextTripNumber)
        try container.encode(nextInternalTripNumber, forKey: .nextInternalTripNumber)
        try container.encode(ISO8601DateFormatter.ACTFormat.string(from: nextTripStartTime), forKey: .nextTripStartTime)
        try container.encode(nextScheduleType, forKey: .nextScheduleType)
        try container.encode(prevTripNumber, forKey: .prevTripNumber)
        try container.encode(prevInternalTripNumber, forKey: .prevInternalTripNumber)
        try container.encode(ISO8601DateFormatter.ACTFormat.string(from: prevTripStartTime), forKey: .prevTripStartTime)
        try container.encode(prevScheduleType, forKey: .prevScheduleType)
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

    public static let sample: TripCancellationInfo = TripCancellationInfo(
        routeAlpha: "51A",
        direction: "NB",
        bookingId: "25FASU",
        canceled: true,
        reinstated: false,
        tripNumber: 1001,
        internalTripNumber: 5001,
        tripStartTime: ISO8601DateFormatter.ACTQueryFormat.date(from: "2025-05-01T09:00:00-07:00")!,
        scheduleType: "Weekday",
        nextTripNumber: 1002,
        nextInternalTripNumber: 5002,
        nextTripStartTime: ISO8601DateFormatter.ACTQueryFormat.date(from: "2025-05-01T09:30:00-07:00")!,
        nextScheduleType: "Weekday",
        prevTripNumber: 1000,
        prevInternalTripNumber: 5000,
        prevTripStartTime: ISO8601DateFormatter.ACTQueryFormat.date(from: "2025-05-01T08:30:00-07:00")!,
        prevScheduleType: "Weekday"
    )

    public static let minimal = TripCancellationInfo(
        routeAlpha: "",
        direction: "",
        bookingId: "",
        canceled: false,
        reinstated: false,
        tripNumber: 0,
        internalTripNumber: 0,
        tripStartTime: .distantPast,
        scheduleType: "",
        nextTripNumber: 0,
        nextInternalTripNumber: 0,
        nextTripStartTime: .distantPast,
        nextScheduleType: "",
        prevTripNumber: 0,
        prevInternalTripNumber: 0,
        prevTripStartTime: .distantPast,
        prevScheduleType: ""
    )

    public static func make(
        routeAlpha: String = sample.routeAlpha,
        direction: String = sample.direction,
        bookingId: String = sample.bookingId,
        canceled: Bool = sample.canceled,
        reinstated: Bool = sample.reinstated,
        tripNumber: Int = sample.tripNumber,
        internalTripNumber: Int = sample.internalTripNumber,
        tripStartTime: Date = sample.tripStartTime,
        scheduleType: String = sample.scheduleType,
        nextTripNumber: Int = sample.nextTripNumber,
        nextInternalTripNumber: Int = sample.nextInternalTripNumber,
        nextTripStartTime: Date = sample.nextTripStartTime,
        nextScheduleType: String = sample.nextScheduleType,
        prevTripNumber: Int = sample.prevTripNumber,
        prevInternalTripNumber: Int = sample.prevInternalTripNumber,
        prevTripStartTime: Date = sample.prevTripStartTime,
        prevScheduleType: String = sample.prevScheduleType
    ) -> TripCancellationInfo {
        TripCancellationInfo(
            routeAlpha: routeAlpha,
            direction: direction,
            bookingId: bookingId,
            canceled: canceled,
            reinstated: reinstated,
            tripNumber: tripNumber,
            internalTripNumber: internalTripNumber,
            tripStartTime: tripStartTime,
            scheduleType: scheduleType,
            nextTripNumber: nextTripNumber,
            nextInternalTripNumber: nextInternalTripNumber,
            nextTripStartTime: nextTripStartTime,
            nextScheduleType: nextScheduleType,
            prevTripNumber: prevTripNumber,
            prevInternalTripNumber: prevInternalTripNumber,
            prevTripStartTime: prevTripStartTime,
            prevScheduleType: prevScheduleType
        )
    }
}

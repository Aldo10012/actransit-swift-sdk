import Foundation

/// https://api.actransit.org/transit/Help/Api/GET-trips-canceled
public struct TripException: Codable, Sendable {
    public let tripExceptionId: Int
    public let eventType: String
    public let incidentId: String
    public let incidentUniqueId: Int
    public let openDateTime: Date
    public let incidentAddDateTime: Date
    public let scheduleType: String
    public let sourceType: String
    public let tripNumber: Int
    public let internalTripNumber: Int
    public let tripStartTime: Date
    public let routeAlpha: String
    public let direction: String
    public let patternId: Int
    public let bookingId: String
    public let fromId511: String
    public let fromStopId: String
    public let toId511: String
    public let toStopId: String
    public let fromStopDescription: String
    public let fromStopLatitude: Double
    public let fromStopLongitude: Double
    public let toStopDescription: String
    public let toStopLatitude: Double
    public let toStopLongitude: Double
    public let stopsInOrder: String

    public init(
        tripExceptionId: Int,
        eventType: String,
        incidentId: String,
        incidentUniqueId: Int,
        openDateTime: Date,
        incidentAddDateTime: Date,
        scheduleType: String,
        sourceType: String,
        tripNumber: Int,
        internalTripNumber: Int,
        tripStartTime: Date,
        routeAlpha: String,
        direction: String,
        patternId: Int,
        bookingId: String,
        fromId511: String,
        fromStopId: String,
        toId511: String,
        toStopId: String,
        fromStopDescription: String,
        fromStopLatitude: Double,
        fromStopLongitude: Double,
        toStopDescription: String,
        toStopLatitude: Double,
        toStopLongitude: Double,
        stopsInOrder: String
    ) {
        self.tripExceptionId = tripExceptionId
        self.eventType = eventType
        self.incidentId = incidentId
        self.incidentUniqueId = incidentUniqueId
        self.openDateTime = openDateTime
        self.incidentAddDateTime = incidentAddDateTime
        self.scheduleType = scheduleType
        self.sourceType = sourceType
        self.tripNumber = tripNumber
        self.internalTripNumber = internalTripNumber
        self.tripStartTime = tripStartTime
        self.routeAlpha = routeAlpha
        self.direction = direction
        self.patternId = patternId
        self.bookingId = bookingId
        self.fromId511 = fromId511
        self.fromStopId = fromStopId
        self.toId511 = toId511
        self.toStopId = toStopId
        self.fromStopDescription = fromStopDescription
        self.fromStopLatitude = fromStopLatitude
        self.fromStopLongitude = fromStopLongitude
        self.toStopDescription = toStopDescription
        self.toStopLatitude = toStopLatitude
        self.toStopLongitude = toStopLongitude
        self.stopsInOrder = stopsInOrder
    }

    enum CodingKeys: String, CodingKey {
        case tripExceptionId = "TripExceptionId"
        case eventType = "EventType"
        case incidentId = "IncidentId"
        case incidentUniqueId = "IncidentUniqueId"
        case openDateTime = "OpenDateTime"
        case incidentAddDateTime = "IncidentAddDateTime"
        case scheduleType = "ScheduleType"
        case sourceType = "SourceType"
        case tripNumber = "TripNumber"
        case internalTripNumber = "InternalTripNumber"
        case tripStartTime = "TripStartTime"
        case routeAlpha = "RouteAlpha"
        case direction = "Direction"
        case patternId = "PatternId"
        case bookingId = "BookingId"
        case fromId511 = "FromId511"
        case fromStopId = "FromStopId"
        case toId511 = "ToId511"
        case toStopId = "ToStopId"
        case fromStopDescription = "FromStopDescription"
        case fromStopLatitude = "FromStopLatitude"
        case fromStopLongitude = "FromStopLongitude"
        case toStopDescription = "ToStopDescription"
        case toStopLatitude = "ToStopLatitude"
        case toStopLongitude = "ToStopLongitude"
        case stopsInOrder = "StopsInOrder"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        tripExceptionId = try container.decode(Int.self, forKey: .tripExceptionId)
        eventType = try container.decode(String.self, forKey: .eventType)
        incidentId = try container.decode(String.self, forKey: .incidentId)
        incidentUniqueId = try container.decode(Int.self, forKey: .incidentUniqueId)
        openDateTime = try Self.parseDate(container.decode(String.self, forKey: .openDateTime), key: "OpenDateTime")
        incidentAddDateTime = try Self.parseDate(container.decode(String.self, forKey: .incidentAddDateTime), key: "IncidentAddDateTime")
        scheduleType = try container.decode(String.self, forKey: .scheduleType)
        sourceType = try container.decode(String.self, forKey: .sourceType)
        tripNumber = try container.decode(Int.self, forKey: .tripNumber)
        internalTripNumber = try container.decode(Int.self, forKey: .internalTripNumber)
        tripStartTime = try Self.parseDate(container.decode(String.self, forKey: .tripStartTime), key: "TripStartTime")
        routeAlpha = try container.decode(String.self, forKey: .routeAlpha)
        direction = try container.decode(String.self, forKey: .direction)
        patternId = try container.decode(Int.self, forKey: .patternId)
        bookingId = try container.decode(String.self, forKey: .bookingId)
        fromId511 = try container.decode(String.self, forKey: .fromId511)
        fromStopId = try container.decode(String.self, forKey: .fromStopId)
        toId511 = try container.decode(String.self, forKey: .toId511)
        toStopId = try container.decode(String.self, forKey: .toStopId)
        fromStopDescription = try container.decode(String.self, forKey: .fromStopDescription)
        fromStopLatitude = try container.decode(Double.self, forKey: .fromStopLatitude)
        fromStopLongitude = try container.decode(Double.self, forKey: .fromStopLongitude)
        toStopDescription = try container.decode(String.self, forKey: .toStopDescription)
        toStopLatitude = try container.decode(Double.self, forKey: .toStopLatitude)
        toStopLongitude = try container.decode(Double.self, forKey: .toStopLongitude)
        stopsInOrder = try container.decode(String.self, forKey: .stopsInOrder)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(tripExceptionId, forKey: .tripExceptionId)
        try container.encode(eventType, forKey: .eventType)
        try container.encode(incidentId, forKey: .incidentId)
        try container.encode(incidentUniqueId, forKey: .incidentUniqueId)
        try container.encode(ISO8601DateFormatter.ACTFormat.string(from: openDateTime), forKey: .openDateTime)
        try container.encode(ISO8601DateFormatter.ACTFormat.string(from: incidentAddDateTime), forKey: .incidentAddDateTime)
        try container.encode(scheduleType, forKey: .scheduleType)
        try container.encode(sourceType, forKey: .sourceType)
        try container.encode(tripNumber, forKey: .tripNumber)
        try container.encode(internalTripNumber, forKey: .internalTripNumber)
        try container.encode(ISO8601DateFormatter.ACTFormat.string(from: tripStartTime), forKey: .tripStartTime)
        try container.encode(routeAlpha, forKey: .routeAlpha)
        try container.encode(direction, forKey: .direction)
        try container.encode(patternId, forKey: .patternId)
        try container.encode(bookingId, forKey: .bookingId)
        try container.encode(fromId511, forKey: .fromId511)
        try container.encode(fromStopId, forKey: .fromStopId)
        try container.encode(toId511, forKey: .toId511)
        try container.encode(toStopId, forKey: .toStopId)
        try container.encode(fromStopDescription, forKey: .fromStopDescription)
        try container.encode(fromStopLatitude, forKey: .fromStopLatitude)
        try container.encode(fromStopLongitude, forKey: .fromStopLongitude)
        try container.encode(toStopDescription, forKey: .toStopDescription)
        try container.encode(toStopLatitude, forKey: .toStopLatitude)
        try container.encode(toStopLongitude, forKey: .toStopLongitude)
        try container.encode(stopsInOrder, forKey: .stopsInOrder)
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

    public static let sample = TripException(
        tripExceptionId: 12345,
        eventType: "Canceled",
        incidentId: "INC-001",
        incidentUniqueId: 67890,
        openDateTime: ISO8601DateFormatter.ACTQueryFormat.date(from: "2025-05-01T08:00:00-07:00")!,
        incidentAddDateTime: ISO8601DateFormatter.ACTQueryFormat.date(from: "2025-05-01T07:55:00-07:00")!,
        scheduleType: "Weekday",
        sourceType: "Incident",
        tripNumber: 1001,
        internalTripNumber: 5001,
        tripStartTime: ISO8601DateFormatter.ACTQueryFormat.date(from: "2025-05-01T09:00:00-07:00")!,
        routeAlpha: "51A",
        direction: "NB",
        patternId: 301,
        bookingId: "2604SP",
        fromId511: "51096",
        fromStopId: "1234",
        toId511: "53077",
        toStopId: "5678",
        fromStopDescription: "Main St & 1st Ave",
        fromStopLatitude: 37.8044,
        fromStopLongitude: -122.2711,
        toStopDescription: "Broadway & 5th Ave",
        toStopLatitude: 37.8102,
        toStopLongitude: -122.2705,
        stopsInOrder: "1234,2345,3456,5678"
    )

    public static let minimal = TripException(
        tripExceptionId: 0,
        eventType: "",
        incidentId: "",
        incidentUniqueId: 0,
        openDateTime: .distantPast,
        incidentAddDateTime: .distantPast,
        scheduleType: "",
        sourceType: "",
        tripNumber: 0,
        internalTripNumber: 0,
        tripStartTime: .distantPast,
        routeAlpha: "",
        direction: "",
        patternId: 0,
        bookingId: "",
        fromId511: "",
        fromStopId: "",
        toId511: "",
        toStopId: "",
        fromStopDescription: "",
        fromStopLatitude: 0,
        fromStopLongitude: 0,
        toStopDescription: "",
        toStopLatitude: 0,
        toStopLongitude: 0,
        stopsInOrder: ""
    )

    public static func make(
        tripExceptionId: Int = sample.tripExceptionId,
        eventType: String = sample.eventType,
        incidentId: String = sample.incidentId,
        incidentUniqueId: Int = sample.incidentUniqueId,
        openDateTime: Date = sample.openDateTime,
        incidentAddDateTime: Date = sample.incidentAddDateTime,
        scheduleType: String = sample.scheduleType,
        sourceType: String = sample.sourceType,
        tripNumber: Int = sample.tripNumber,
        internalTripNumber: Int = sample.internalTripNumber,
        tripStartTime: Date = sample.tripStartTime,
        routeAlpha: String = sample.routeAlpha,
        direction: String = sample.direction,
        patternId: Int = sample.patternId,
        bookingId: String = sample.bookingId,
        fromId511: String = sample.fromId511,
        fromStopId: String = sample.fromStopId,
        toId511: String = sample.toId511,
        toStopId: String = sample.toStopId,
        fromStopDescription: String = sample.fromStopDescription,
        fromStopLatitude: Double = sample.fromStopLatitude,
        fromStopLongitude: Double = sample.fromStopLongitude,
        toStopDescription: String = sample.toStopDescription,
        toStopLatitude: Double = sample.toStopLatitude,
        toStopLongitude: Double = sample.toStopLongitude,
        stopsInOrder: String = sample.stopsInOrder
    ) -> TripException {
        TripException(
            tripExceptionId: tripExceptionId,
            eventType: eventType,
            incidentId: incidentId,
            incidentUniqueId: incidentUniqueId,
            openDateTime: openDateTime,
            incidentAddDateTime: incidentAddDateTime,
            scheduleType: scheduleType,
            sourceType: sourceType,
            tripNumber: tripNumber,
            internalTripNumber: internalTripNumber,
            tripStartTime: tripStartTime,
            routeAlpha: routeAlpha,
            direction: direction,
            patternId: patternId,
            bookingId: bookingId,
            fromId511: fromId511,
            fromStopId: fromStopId,
            toId511: toId511,
            toStopId: toStopId,
            fromStopDescription: fromStopDescription,
            fromStopLatitude: fromStopLatitude,
            fromStopLongitude: fromStopLongitude,
            toStopDescription: toStopDescription,
            toStopLatitude: toStopLatitude,
            toStopLongitude: toStopLongitude,
            stopsInOrder: stopsInOrder
        )
    }
}

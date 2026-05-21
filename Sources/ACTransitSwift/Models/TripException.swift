import Foundation

/// https://api.actransit.org/transit/Help/Api/GET-trips-canceled
public struct TripException: Codable, Sendable {
    public let tripExceptionId: Int
    public let eventType: String
    public let incidentId: String
    public let incidentUniqueId: Int
    public let openDateTime: Date
    public let incidentAddDateTime: Date
    public let tripStartTime: Date
    public let routeAlpha: String
    public let direction: String
    public let tripNumber: Int
    public let internalTripNumber: Int
    public let patternId: Int
    public let fromStopId: String
    public let toStopId: String
    public let fromStopDescription: String
    public let toStopDescription: String
    public let fromStopLatitude: Double
    public let fromStopLongitude: Double
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
        tripStartTime: Date,
        routeAlpha: String,
        direction: String,
        tripNumber: Int,
        internalTripNumber: Int,
        patternId: Int,
        fromStopId: String,
        toStopId: String,
        fromStopDescription: String,
        toStopDescription: String,
        fromStopLatitude: Double,
        fromStopLongitude: Double,
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
        self.tripStartTime = tripStartTime
        self.routeAlpha = routeAlpha
        self.direction = direction
        self.tripNumber = tripNumber
        self.internalTripNumber = internalTripNumber
        self.patternId = patternId
        self.fromStopId = fromStopId
        self.toStopId = toStopId
        self.fromStopDescription = fromStopDescription
        self.toStopDescription = toStopDescription
        self.fromStopLatitude = fromStopLatitude
        self.fromStopLongitude = fromStopLongitude
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
        case tripStartTime = "TripStartTime"
        case routeAlpha = "RouteAlpha"
        case direction = "Direction"
        case tripNumber = "TripNumber"
        case internalTripNumber = "InternalTripNumber"
        case patternId = "PatternId"
        case fromStopId = "FromStopId"
        case toStopId = "ToStopId"
        case fromStopDescription = "FromStopDescription"
        case toStopDescription = "ToStopDescription"
        case fromStopLatitude = "FromStopLatitude"
        case fromStopLongitude = "FromStopLongitude"
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
        tripStartTime = try Self.parseDate(container.decode(String.self, forKey: .tripStartTime), key: "TripStartTime")
        routeAlpha = try container.decode(String.self, forKey: .routeAlpha)
        direction = try container.decode(String.self, forKey: .direction)
        tripNumber = try container.decode(Int.self, forKey: .tripNumber)
        internalTripNumber = try container.decode(Int.self, forKey: .internalTripNumber)
        patternId = try container.decode(Int.self, forKey: .patternId)
        fromStopId = try container.decode(String.self, forKey: .fromStopId)
        toStopId = try container.decode(String.self, forKey: .toStopId)
        fromStopDescription = try container.decode(String.self, forKey: .fromStopDescription)
        toStopDescription = try container.decode(String.self, forKey: .toStopDescription)
        fromStopLatitude = try container.decode(Double.self, forKey: .fromStopLatitude)
        fromStopLongitude = try container.decode(Double.self, forKey: .fromStopLongitude)
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
        try container.encode(ISO8601DateFormatter.ACTFormat.string(from: tripStartTime), forKey: .tripStartTime)
        try container.encode(routeAlpha, forKey: .routeAlpha)
        try container.encode(direction, forKey: .direction)
        try container.encode(tripNumber, forKey: .tripNumber)
        try container.encode(internalTripNumber, forKey: .internalTripNumber)
        try container.encode(patternId, forKey: .patternId)
        try container.encode(fromStopId, forKey: .fromStopId)
        try container.encode(toStopId, forKey: .toStopId)
        try container.encode(fromStopDescription, forKey: .fromStopDescription)
        try container.encode(toStopDescription, forKey: .toStopDescription)
        try container.encode(fromStopLatitude, forKey: .fromStopLatitude)
        try container.encode(fromStopLongitude, forKey: .fromStopLongitude)
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

    public static let sample: TripException = TripException(
            tripExceptionId: 12345,
            eventType: "Canceled",
            incidentId: "INC-001",
            incidentUniqueId: 67890,
            openDateTime: ISO8601DateFormatter.ACTQueryFormat.date(from: "2025-05-01T08:00:00-07:00")!,
            incidentAddDateTime: ISO8601DateFormatter.ACTQueryFormat.date(from: "2025-05-01T07:55:00-07:00")!,
            tripStartTime: ISO8601DateFormatter.ACTQueryFormat.date(from: "2025-05-01T09:00:00-07:00")!,
            routeAlpha: "51A",
            direction: "NB",
            tripNumber: 1001,
            internalTripNumber: 5001,
            patternId: 301,
            fromStopId: "1234",
            toStopId: "5678",
            fromStopDescription: "Main St & 1st Ave",
            toStopDescription: "Broadway & 5th Ave",
            fromStopLatitude: 37.8044,
            fromStopLongitude: -122.2711,
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
        tripStartTime: .distantPast,
        routeAlpha: "",
        direction: "",
        tripNumber: 0,
        internalTripNumber: 0,
        patternId: 0,
        fromStopId: "",
        toStopId: "",
        fromStopDescription: "",
        toStopDescription: "",
        fromStopLatitude: 0,
        fromStopLongitude: 0,
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
        tripStartTime: Date = sample.tripStartTime,
        routeAlpha: String = sample.routeAlpha,
        direction: String = sample.direction,
        tripNumber: Int = sample.tripNumber,
        internalTripNumber: Int = sample.internalTripNumber,
        patternId: Int = sample.patternId,
        fromStopId: String = sample.fromStopId,
        toStopId: String = sample.toStopId,
        fromStopDescription: String = sample.fromStopDescription,
        toStopDescription: String = sample.toStopDescription,
        fromStopLatitude: Double = sample.fromStopLatitude,
        fromStopLongitude: Double = sample.fromStopLongitude,
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
            tripStartTime: tripStartTime,
            routeAlpha: routeAlpha,
            direction: direction,
            tripNumber: tripNumber,
            internalTripNumber: internalTripNumber,
            patternId: patternId,
            fromStopId: fromStopId,
            toStopId: toStopId,
            fromStopDescription: fromStopDescription,
            toStopDescription: toStopDescription,
            fromStopLatitude: fromStopLatitude,
            fromStopLongitude: fromStopLongitude,
            toStopLatitude: toStopLatitude,
            toStopLongitude: toStopLongitude,
            stopsInOrder: stopsInOrder
        )
    }
}

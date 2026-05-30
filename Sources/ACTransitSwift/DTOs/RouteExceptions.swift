import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=RouteExceptions
public struct RouteExceptions: Codable, Sendable {
    /// Unique id that represents a specific schedule name for the period of time associated with the data requested.
    public let bookingId: String
    /// Collection of date exceptions.
    public let dateExceptions: [DateException]

    public init(bookingId: String, dateExceptions: [DateException]) {
        self.bookingId = bookingId
        self.dateExceptions = dateExceptions
    }

    enum CodingKeys: String, CodingKey {
        case bookingId = "BookingId"
        case dateExceptions = "DateExceptions"
    }

    // MARK: - Mock Data

    public static let sample = RouteExceptions(
        bookingId: "2604SP",
        dateExceptions: [DateException.sample]
    )

    public static func make(
        bookingId: String = sample.bookingId,
        dateExceptions: [DateException] = sample.dateExceptions
    ) -> RouteExceptions {
        RouteExceptions(bookingId: bookingId, dateExceptions: dateExceptions)
    }
}

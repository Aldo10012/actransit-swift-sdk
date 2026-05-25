import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=TimeRequestResponse
public struct TimeRequestResponse: Codable, Sendable {
    /// Current system date and time in local timezone. Format is `YYYYMMDD HH:MM:SS`.
    /// If `unixTime=true` was requested, contains milliseconds elapsed since Unix epoch (UTC, 1 Jan 1970).
    public let tm: String
    /// Errors from request processing.
    public let error: [BusTimeError]?

    public init(tm: String, error: [BusTimeError]? = nil) {
        self.tm = tm
        self.error = error
    }

    // MARK: - Mock Data

    public static let sample = TimeRequestResponse(tm: "20230615 14:30:00")

    public static func make(
        tm: String = sample.tm,
        error: [BusTimeError]? = sample.error
    ) -> TimeRequestResponse {
        TimeRequestResponse(tm: tm, error: error)
    }
}

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=RequestResponseOfTimeRequestResponse
public typealias RequestResponseOfTimeRequestResponse = BustimeResponse<TimeRequestResponse>

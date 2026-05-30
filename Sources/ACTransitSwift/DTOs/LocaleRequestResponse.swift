import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=LocaleRequestResponse
public struct LocaleRequestResponse: Codable, Sendable {
    /// Available language locales for the BusTime system.
    public let locale: [BusTimeLocale]
    /// Errors from request processing.
    public let error: [BusTimeError]?

    public init(locale: [BusTimeLocale], error: [BusTimeError]? = nil) {
        self.locale = locale
        self.error = error
    }
}

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=RequestResponseOfLocaleRequestResponse
public typealias RequestResponseOfLocaleRequestResponse = BusTimeResponse<LocaleRequestResponse>

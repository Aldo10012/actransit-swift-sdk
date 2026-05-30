import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=Locale
public struct BusTimeLocale: Codable, Sendable {
    /// Unique name/identifier of the locale. This is what is passed as the locale parameter in all API calls.
    public let localeString: String
    /// The name of the language.
    public let displayName: String

    public init(localeString: String, displayName: String) {
        self.localeString = localeString
        self.displayName = displayName
    }

    enum CodingKeys: String, CodingKey {
        case localeString = "localestring"
        case displayName = "displayname"
    }

    // MARK: - Mock Data

    public static let sample = BusTimeLocale(localeString: "en", displayName: "English")

    public static func make(
        localeString: String = sample.localeString,
        displayName: String = sample.displayName
    ) -> BusTimeLocale {
        BusTimeLocale(localeString: localeString, displayName: displayName)
    }
}

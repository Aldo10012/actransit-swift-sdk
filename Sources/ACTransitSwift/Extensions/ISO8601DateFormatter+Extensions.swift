import Foundation

extension ISO8601DateFormatter {
    /// Internet date-time with fractional seconds — used for encoding/decoding API response date fields.
    nonisolated(unsafe) static let ACTFormat: ISO8601DateFormatter = {
        let f = ISO8601DateFormatter()
        f.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return f
    }()

    /// Internet date-time without fractional seconds — used for formatting query parameter dates.
    nonisolated(unsafe) static let ACTQueryFormat: ISO8601DateFormatter = {
        let f = ISO8601DateFormatter()
        f.formatOptions = [.withInternetDateTime]
        return f
    }()
}

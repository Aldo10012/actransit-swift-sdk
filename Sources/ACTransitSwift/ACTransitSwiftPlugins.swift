import Foundation

public struct ACTSwiftPlugins {
    nonisolated(unsafe) private(set) static var apiToken: String = ""
    internal static let apiBaseURL: String = "https://api.actransit.org/transit"

    private init() {}

    public static func install(token: String) {
        ACTSwiftPlugins.apiToken = token
    }

    static func cleanup() {
        ACTSwiftPlugins.apiToken = ""
    }
}

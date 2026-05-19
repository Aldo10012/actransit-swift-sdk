import Foundation

public struct ACTSwiftPlugins {
    private(set) nonisolated(unsafe) static var apiToken = ""
    static let apiBaseURL = "https://api.actransit.org/transit"

    private init() {}

    public static func install(token: String) {
        ACTSwiftPlugins.apiToken = token
    }

    static func cleanup() {
        ACTSwiftPlugins.apiToken = ""
    }
}

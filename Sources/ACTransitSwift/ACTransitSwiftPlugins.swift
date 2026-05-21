import Foundation

public struct ACTSwiftPlugins {
    private static let lock = NSLock()
    private nonisolated(unsafe) static var _apiToken = ""

    static let apiBaseURL = "https://api.actransit.org/transit"

    private init() {}

    static var apiToken: String {
        lock.withLock { _apiToken }
    }

    public static func install(token: String) {
        lock.withLock { _apiToken = token }
    }

    static func cleanup() {
        lock.withLock { _apiToken = "" }
    }
}

import Foundation

@MainActor
public struct ACTransitSwiftPlugins {
    private(set) static var apiToken: String?

    private init() {}

    public static func install(token: String) {
        ACTransitSwiftPlugins.apiToken = token
    }

    static func cleanup() {
        ACTransitSwiftPlugins.apiToken = nil
    }
}

@testable import ACTransitSwift
import EZNetworking
import Foundation
import Testing

@Suite("Test ActRealtimeEndpoint")
final class ActRealtimeEndpointTests {
    enum Constants {
        static let tokenKey = "token"
        static let mockToken = "mockToken"
    }

    @Test("test ActRealtimeEndpoint.detour")
    func detour() {
        let endpoint = ActRealtimeEndpoint.detour(route: "51A", direction: "TO DOWNTOWN BERKELEY", callback: "myCallback")
        let request = endpoint.getRequest(token: Constants.mockToken)

        #expect(endpoint.path == "/actrealtime/detour")
        #expect(request.httpMethod == .GET)
        #expect(request.baseUrl == "https://api.actransit.org/transit/actrealtime/detour")
        #expect((request.parameters ?? []).contains(HTTPParameter(key: Constants.tokenKey, value: Constants.mockToken)))
        #expect((request.parameters ?? []).contains(HTTPParameter(key: "rt", value: "51A")))
        #expect((request.parameters ?? []).contains(HTTPParameter(key: "rtdir", value: "TO DOWNTOWN BERKELEY")))
        #expect((request.parameters ?? []).contains(HTTPParameter(key: "callback", value: "myCallback")))
    }
}

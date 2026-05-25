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

    @Test("test ActRealtimeEndpoint.direction")
    func direction() {
        let endpoint = ActRealtimeEndpoint.direction(route: "51A", callback: "myCallback")
        let request = endpoint.getRequest(token: Constants.mockToken)

        #expect(endpoint.path == "/actrealtime/direction")
        #expect(request.httpMethod == .GET)
        #expect(request.baseUrl == "https://api.actransit.org/transit/actrealtime/direction")
        #expect((request.parameters ?? []).contains(HTTPParameter(key: Constants.tokenKey, value: Constants.mockToken)))
        #expect((request.parameters ?? []).contains(HTTPParameter(key: "rt", value: "51A")))
        #expect((request.parameters ?? []).contains(HTTPParameter(key: "callback", value: "myCallback")))
    }

    @Test("test ActRealtimeEndpoint.line")
    func line() {
        let endpoint = ActRealtimeEndpoint.line(callback: "myCallback")
        let request = endpoint.getRequest(token: Constants.mockToken)

        #expect(endpoint.path == "/actrealtime/line")
        #expect(request.httpMethod == .GET)
        #expect(request.baseUrl == "https://api.actransit.org/transit/actrealtime/line")
        #expect((request.parameters ?? []).contains(HTTPParameter(key: Constants.tokenKey, value: Constants.mockToken)))
        #expect((request.parameters ?? []).contains(HTTPParameter(key: "callback", value: "myCallback")))
    }

    @Test("test ActRealtimeEndpoint.locale")
    func locale() {
        let endpoint = ActRealtimeEndpoint.locale(callback: "myCallback")
        let request = endpoint.getRequest(token: Constants.mockToken)

        #expect(endpoint.path == "/actrealtime/locale")
        #expect(request.httpMethod == .GET)
        #expect(request.baseUrl == "https://api.actransit.org/transit/actrealtime/locale")
        #expect((request.parameters ?? []).contains(HTTPParameter(key: Constants.tokenKey, value: Constants.mockToken)))
        #expect((request.parameters ?? []).contains(HTTPParameter(key: "callback", value: "myCallback")))
    }
}

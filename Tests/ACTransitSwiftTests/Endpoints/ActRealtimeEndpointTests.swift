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

    @Test("test ActRealtimeEndpoint.pattern")
    func pattern() {
        let endpoint = ActRealtimeEndpoint.pattern(patternIds: "12345", route: "51A", callback: "myCallback")
        let request = endpoint.getRequest(token: Constants.mockToken)

        #expect(endpoint.path == "/actrealtime/pattern")
        #expect(request.httpMethod == .GET)
        #expect(request.baseUrl == "https://api.actransit.org/transit/actrealtime/pattern")
        #expect((request.parameters ?? []).contains(HTTPParameter(key: Constants.tokenKey, value: Constants.mockToken)))
        #expect((request.parameters ?? []).contains(HTTPParameter(key: "pid", value: "12345")))
        #expect((request.parameters ?? []).contains(HTTPParameter(key: "rt", value: "51A")))
        #expect((request.parameters ?? []).contains(HTTPParameter(key: "callback", value: "myCallback")))
    }

    @Test("test ActRealtimeEndpoint.prediction")
    func prediction() {
        let endpoint = ActRealtimeEndpoint.prediction(stopId: "55123", route: "51A", vehicleId: "5016", top: 5, tmres: "s", showocprd: true, callback: "myCallback")
        let request = endpoint.getRequest(token: Constants.mockToken)

        #expect(endpoint.path == "/actrealtime/prediction")
        #expect(request.httpMethod == .GET)
        #expect(request.baseUrl == "https://api.actransit.org/transit/actrealtime/prediction")
        #expect((request.parameters ?? []).contains(HTTPParameter(key: Constants.tokenKey, value: Constants.mockToken)))
        #expect((request.parameters ?? []).contains(HTTPParameter(key: "stpid", value: "55123")))
        #expect((request.parameters ?? []).contains(HTTPParameter(key: "rt", value: "51A")))
        #expect((request.parameters ?? []).contains(HTTPParameter(key: "vid", value: "5016")))
        #expect((request.parameters ?? []).contains(HTTPParameter(key: "top", value: "5")))
        #expect((request.parameters ?? []).contains(HTTPParameter(key: "tmres", value: "s")))
        #expect((request.parameters ?? []).contains(HTTPParameter(key: "showocprd", value: "true")))
        #expect((request.parameters ?? []).contains(HTTPParameter(key: "callback", value: "myCallback")))
    }

    @Test("test ActRealtimeEndpoint.time")
    func time() {
        let endpoint = ActRealtimeEndpoint.time(unixTime: true, callback: "myCallback")
        let request = endpoint.getRequest(token: Constants.mockToken)

        #expect(endpoint.path == "/actrealtime/time")
        #expect(request.httpMethod == .GET)
        #expect(request.baseUrl == "https://api.actransit.org/transit/actrealtime/time")
        #expect((request.parameters ?? []).contains(HTTPParameter(key: Constants.tokenKey, value: Constants.mockToken)))
        #expect((request.parameters ?? []).contains(HTTPParameter(key: "unixTime", value: "true")))
        #expect((request.parameters ?? []).contains(HTTPParameter(key: "callback", value: "myCallback")))
    }

    @Test("test ActRealtimeEndpoint.serviceBulletin")
    func serviceBulletin() {
        let endpoint = ActRealtimeEndpoint.serviceBulletin(routes: "51A", direction: "TO DOWNTOWN BERKELEY", stopId: "55123", callback: "myCallback")
        let request = endpoint.getRequest(token: Constants.mockToken)

        #expect(endpoint.path == "/actrealtime/servicebulletin")
        #expect(request.httpMethod == .GET)
        #expect(request.baseUrl == "https://api.actransit.org/transit/actrealtime/servicebulletin")
        #expect((request.parameters ?? []).contains(HTTPParameter(key: Constants.tokenKey, value: Constants.mockToken)))
        #expect((request.parameters ?? []).contains(HTTPParameter(key: "rt", value: "51A")))
        #expect((request.parameters ?? []).contains(HTTPParameter(key: "rtdir", value: "TO DOWNTOWN BERKELEY")))
        #expect((request.parameters ?? []).contains(HTTPParameter(key: "stpid", value: "55123")))
        #expect((request.parameters ?? []).contains(HTTPParameter(key: "callback", value: "myCallback")))
    }

    @Test("test ActRealtimeEndpoint.stop")
    func stop() {
        let endpoint = ActRealtimeEndpoint.stop(route: "51A", direction: "TO DOWNTOWN BERKELEY", stopId: "55123", callback: "myCallback")
        let request = endpoint.getRequest(token: Constants.mockToken)

        #expect(endpoint.path == "/actrealtime/stop")
        #expect(request.httpMethod == .GET)
        #expect(request.baseUrl == "https://api.actransit.org/transit/actrealtime/stop")
        #expect((request.parameters ?? []).contains(HTTPParameter(key: Constants.tokenKey, value: Constants.mockToken)))
        #expect((request.parameters ?? []).contains(HTTPParameter(key: "rt", value: "51A")))
        #expect((request.parameters ?? []).contains(HTTPParameter(key: "dir", value: "TO DOWNTOWN BERKELEY")))
        #expect((request.parameters ?? []).contains(HTTPParameter(key: "stpid", value: "55123")))
        #expect((request.parameters ?? []).contains(HTTPParameter(key: "callback", value: "myCallback")))
    }

    @Test("test ActRealtimeEndpoint.allStops")
    func allStops() {
        let endpoint = ActRealtimeEndpoint.allStops(route: "51A", limitFields: true, callback: "myCallback")
        let request = endpoint.getRequest(token: Constants.mockToken)

        #expect(endpoint.path == "/actrealtime/allstops")
        #expect(request.httpMethod == .GET)
        #expect(request.baseUrl == "https://api.actransit.org/transit/actrealtime/allstops")
        #expect((request.parameters ?? []).contains(HTTPParameter(key: Constants.tokenKey, value: Constants.mockToken)))
        #expect((request.parameters ?? []).contains(HTTPParameter(key: "rt", value: "51A")))
        #expect((request.parameters ?? []).contains(HTTPParameter(key: "limitFields", value: "true")))
        #expect((request.parameters ?? []).contains(HTTPParameter(key: "callback", value: "myCallback")))
    }

    @Test("test ActRealtimeEndpoint.vehicle")
    func vehicle() {
        let endpoint = ActRealtimeEndpoint.vehicle(vehicleId: "5016", route: "51A", tmres: "s", callback: "myCallback", lat: 37.8558, lng: -122.2597, searchRadius: 500.0)
        let request = endpoint.getRequest(token: Constants.mockToken)

        #expect(endpoint.path == "/actrealtime/vehicle")
        #expect(request.httpMethod == .GET)
        #expect(request.baseUrl == "https://api.actransit.org/transit/actrealtime/vehicle")
        #expect((request.parameters ?? []).contains(HTTPParameter(key: Constants.tokenKey, value: Constants.mockToken)))
        #expect((request.parameters ?? []).contains(HTTPParameter(key: "vid", value: "5016")))
        #expect((request.parameters ?? []).contains(HTTPParameter(key: "rt", value: "51A")))
        #expect((request.parameters ?? []).contains(HTTPParameter(key: "tmres", value: "s")))
        #expect((request.parameters ?? []).contains(HTTPParameter(key: "callback", value: "myCallback")))
        #expect((request.parameters ?? []).contains(HTTPParameter(key: "lat", value: "37.8558")))
        #expect((request.parameters ?? []).contains(HTTPParameter(key: "lng", value: "-122.2597")))
        #expect((request.parameters ?? []).contains(HTTPParameter(key: "searchRadius", value: "500.0")))
    }
}

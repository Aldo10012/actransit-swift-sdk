@testable import ACTransitSwift
import EZNetworking
import Foundation
import Testing

@Suite("Test StopsEndpoint")
final class StopsEndpointTests {
    enum Constants {
        static let tokenKey = "token"
        static let mockToken = "mockToken"
    }

    @Test("test StopsEndpoint.allStops")
    func allStops() {
        let endpoint = StopsEndpoint.allStops
        let request = endpoint.getRequest(token: Constants.mockToken)

        #expect(endpoint.path == "/stops")
        #expect(request.httpMethod == .GET)
        #expect(request.baseUrl == "https://api.actransit.org/transit/stops")
        #expect(request.parameters == [HTTPParameter(key: Constants.tokenKey, value: Constants.mockToken)])
    }

    @Test("test StopsEndpoint.summary")
    func summary() {
        let endpoint = StopsEndpoint.summary
        let request = endpoint.getRequest(token: Constants.mockToken)

        #expect(endpoint.path == "/stops/summary")
        #expect(request.httpMethod == .GET)
        #expect(request.baseUrl == "https://api.actransit.org/transit/stops/summary")
        #expect(request.parameters == [HTTPParameter(key: Constants.tokenKey, value: Constants.mockToken)])
    }

    @Test("test StopsEndpoint.nearbyByPath without optional params")
    func nearbyByPathBasic() {
        let endpoint = StopsEndpoint.nearbyByPath(latitude: 37.9710794, longitude: -122.3398753)
        let request = endpoint.getRequest(token: Constants.mockToken)

        #expect(endpoint.path == "/stops/37.9710794/-122.3398753")
        #expect(request.httpMethod == .GET)
        #expect(request.baseUrl == "https://api.actransit.org/transit/stops/37.9710794/-122.3398753")
        #expect((request.parameters ?? []).contains(HTTPParameter(key: Constants.tokenKey, value: Constants.mockToken)))
    }

    @Test("test StopsEndpoint.nearbyByPath with all params")
    func nearbyByPathFull() {
        let endpoint = StopsEndpoint.nearbyByPath(latitude: 37.9710794, longitude: -122.3398753, distance: 1000.0, active: true, routeName: "72")
        let request = endpoint.getRequest(token: Constants.mockToken)

        #expect(endpoint.path == "/stops/37.9710794/-122.3398753/1000.0/true/72")
        #expect(request.httpMethod == .GET)
        #expect(request.baseUrl == "https://api.actransit.org/transit/stops/37.9710794/-122.3398753/1000.0/true/72")
        #expect((request.parameters ?? []).contains(HTTPParameter(key: Constants.tokenKey, value: Constants.mockToken)))
    }

    @Test("test StopsEndpoint.nearbyByPath with distance only")
    func nearbyByPathDistanceOnly() {
        // distance provided but not active/routeName — path stops after distance segment
        let endpoint = StopsEndpoint.nearbyByPath(latitude: 37.9710794, longitude: -122.3398753, distance: 500.0)
        #expect(endpoint.path == "/stops/37.9710794/-122.3398753/500.0")
    }

    @Test("test StopsEndpoint.nearbyByPath silently drops routeName without distance")
    func nearbyByPathSilentDropWithoutDistance() {
        // routeName without distance is dropped — the API path requires positional ordering
        let endpoint = StopsEndpoint.nearbyByPath(latitude: 37.9710794, longitude: -122.3398753, routeName: "72")
        #expect(endpoint.path == "/stops/37.9710794/-122.3398753")
    }

    @Test("test StopsEndpoint.nearby")
    func nearby() {
        let endpoint = StopsEndpoint.nearby(latitude: 37.9710794, longitude: -122.3398753)
        let request = endpoint.getRequest(token: Constants.mockToken)

        #expect(endpoint.path == "/stops/37.9710794/-122.3398753")
        #expect(request.httpMethod == .GET)
        #expect(request.baseUrl == "https://api.actransit.org/transit/stops/37.9710794/-122.3398753")
        #expect((request.parameters ?? []).contains(HTTPParameter(key: Constants.tokenKey, value: Constants.mockToken)))
    }

    @Test("test StopsEndpoint.nearby with query params")
    func nearbyWithQueryParams() {
        let endpoint = StopsEndpoint.nearby(latitude: 37.9710794, longitude: -122.3398753, distance: 1000.0, active: true, routeName: "72")
        let request = endpoint.getRequest(token: Constants.mockToken)

        #expect(endpoint.path == "/stops/37.9710794/-122.3398753")
        #expect((request.parameters ?? []).contains(HTTPParameter(key: "distance", value: "1000.0")))
        #expect((request.parameters ?? []).contains(HTTPParameter(key: "active", value: "true")))
        #expect((request.parameters ?? []).contains(HTTPParameter(key: "routeName", value: "72")))
    }

    @Test("test StopsEndpoint.stopRoutes")
    func stopRoutes() {
        let endpoint = StopsEndpoint.stopRoutes(stopId: 55888)
        let request = endpoint.getRequest(token: Constants.mockToken)

        #expect(endpoint.path == "/stops/55888/routes")
        #expect(request.httpMethod == .GET)
        #expect(request.baseUrl == "https://api.actransit.org/transit/stops/55888/routes")
        #expect((request.parameters ?? []).contains(HTTPParameter(key: Constants.tokenKey, value: Constants.mockToken)))
    }

    @Test("test StopsEndpoint.tripsToday")
    func tripsToday() {
        let endpoint = StopsEndpoint.tripsToday(stopId: 55888)
        let request = endpoint.getRequest(token: Constants.mockToken)

        #expect(endpoint.path == "/stops/55888/tripstoday")
        #expect(request.httpMethod == .GET)
        #expect(request.baseUrl == "https://api.actransit.org/transit/stops/55888/tripstoday")
        #expect((request.parameters ?? []).contains(HTTPParameter(key: Constants.tokenKey, value: Constants.mockToken)))
    }

    @Test("test StopsEndpoint.tripsToday with filters")
    func tripsTodayWithFilters() {
        let endpoint = StopsEndpoint.tripsToday(stopId: 55888, routes: "72,72R", direction: "Southbound")
        let request = endpoint.getRequest(token: Constants.mockToken)

        #expect(endpoint.path == "/stops/55888/tripstoday")
        #expect((request.parameters ?? []).contains(HTTPParameter(key: "routes", value: "72,72R")))
        #expect((request.parameters ?? []).contains(HTTPParameter(key: "direction", value: "Southbound")))
    }

    @Test("test StopsEndpoint.destinations")
    func destinations() {
        let endpoint = StopsEndpoint.destinations(stopId: 55888)
        let request = endpoint.getRequest(token: Constants.mockToken)

        #expect(endpoint.path == "/stop/55888/destinations")
        #expect(request.httpMethod == .GET)
        #expect(request.baseUrl == "https://api.actransit.org/transit/stop/55888/destinations")
        #expect((request.parameters ?? []).contains(HTTPParameter(key: Constants.tokenKey, value: Constants.mockToken)))
    }

    @Test("test StopsEndpoint.profile")
    func profile() {
        let endpoint = StopsEndpoint.profile(stopId: 55888)
        let request = endpoint.getRequest(token: Constants.mockToken)

        #expect(endpoint.path == "/stop/55888/profile")
        #expect(request.httpMethod == .GET)
        #expect(request.baseUrl == "https://api.actransit.org/transit/stop/55888/profile")
        #expect((request.parameters ?? []).contains(HTTPParameter(key: Constants.tokenKey, value: Constants.mockToken)))
    }
}

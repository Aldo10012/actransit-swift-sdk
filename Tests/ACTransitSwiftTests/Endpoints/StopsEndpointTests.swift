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
}

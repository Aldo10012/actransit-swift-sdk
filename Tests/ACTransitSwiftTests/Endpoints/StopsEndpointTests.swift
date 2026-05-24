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
}

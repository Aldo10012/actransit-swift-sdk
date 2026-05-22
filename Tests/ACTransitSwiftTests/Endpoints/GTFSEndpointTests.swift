@testable import ACTransitSwift
import EZNetworking
import Foundation
import Testing

@Suite("Test GTFSEndpoint")
final class GTFSEndpointTests {
    enum Constants {
        static let tokenKey = "token"
        static let mockToken = "mockToken"
    }

    @Test("test GTFSEndpoint.active")
    func active() {
        let endpoint = GTFSEndpoint.active
        let request = endpoint.getRequest(token: Constants.mockToken)

        #expect(endpoint.path == "/gtfs")
        #expect(request.httpMethod == .GET)
        #expect(request.baseUrl == "https://api.actransit.org/transit/gtfs")
        #expect(request.parameters == [HTTPParameter(key: Constants.tokenKey, value: Constants.mockToken)])
    }

    @Test("test GTFSEndpoint.all")
    func all() {
        let endpoint = GTFSEndpoint.all
        let request = endpoint.getRequest(token: Constants.mockToken)

        #expect(endpoint.path == "/gtfs/all")
        #expect(request.httpMethod == .GET)
        #expect(request.baseUrl == "https://api.actransit.org/transit/gtfs/all")
        #expect(request.parameters == [HTTPParameter(key: Constants.tokenKey, value: Constants.mockToken)])
    }
}

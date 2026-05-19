@testable import ACTransitSwift
import EZNetworking
import Testing

@Suite("Test ACTEndpoint")
final class ACTEndpointTests {

    // MARK: constants

    enum Constants {
        static let tokenKey = "token"
        static let mockToken = "mockToken"
    }

    // MARK: setup

    init() {
        ACTSwiftPlugins.install(token: Constants.mockToken)
    }

    // MARK: teardown

    deinit {
        ACTSwiftPlugins.cleanup()
    }

    // MARK: - unit tests

    @Test("test ACTEndpoint.gtfs")
    func gtfs() {
        let endpoint = ACTEndpoint.gtfs
        let request = endpoint.getRequest()

        #expect(endpoint.path == "/gtfs")
        #expect(request.httpMethod == .GET)
        #expect(request.baseUrl == "https://api.actransit.org/transit/gtfs")
        #expect(request.parameters == [HTTPParameter(key: Constants.tokenKey, value: Constants.mockToken)])
    }

    @Test("test ACTEndpoint.gtfsAll")
    func gtfsAll() {
        let endpoint = ACTEndpoint.gtfsAll
        let request = endpoint.getRequest()

        #expect(endpoint.path == "/gtfs/all")
        #expect(request.httpMethod == .GET)
        #expect(request.baseUrl == "https://api.actransit.org/transit/gtfs/all")
        #expect(request.parameters == [HTTPParameter(key: Constants.tokenKey, value: Constants.mockToken)])
    }

}

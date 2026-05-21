@testable import ACTransitSwift
import EZNetworking
import Foundation
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

    @Test("test ACTEndpoint.tripsCanceled with no optional params")
    func tripsCanceled() {
        let endpoint = ACTEndpoint.tripsCanceled()
        let request = endpoint.getRequest()

        #expect(endpoint.path == "/trips/canceled")
        #expect(request.httpMethod == .GET)
        #expect(request.baseUrl == "https://api.actransit.org/transit/trips/canceled")
        #expect(request.parameters == [HTTPParameter(key: Constants.tokenKey, value: Constants.mockToken)])
    }

    @Test("test ACTEndpoint.tripsTripCancellationInfo")
    func tripsTripCancellationInfo() {
        let endpoint = ACTEndpoint.tripsTripCancellationInfo(tripNumber: 1001)
        let request = endpoint.getRequest()

        #expect(endpoint.path == "/trips/tripcancellationinfo/1001")
        #expect(request.httpMethod == .GET)
        #expect(request.baseUrl == "https://api.actransit.org/transit/trips/tripcancellationinfo/1001")
        #expect(request.parameters == [HTTPParameter(key: Constants.tokenKey, value: Constants.mockToken)])
    }

    @Test("test ACTEndpoint.tripsCanceled includes optional params when provided")
    func tripsCanceledWithParams() {
        let openDate = Date(timeIntervalSince1970: 1_746_100_000)
        let fromDate = Date(timeIntervalSince1970: 1_746_200_000)
        let toDate = Date(timeIntervalSince1970: 1_746_300_000)
        let endpoint = ACTEndpoint.tripsCanceled(
            lastIncidentUniqueId: 42,
            lastOpenDateTime: openDate,
            tripDateTimeFrom: fromDate,
            tripDateTimeTo: toDate
        )
        let request = endpoint.getRequest()

        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]

        #expect(endpoint.path == "/trips/canceled")
        #expect(request.httpMethod == .GET)
        #expect(request.parameters?.count == 5)
        #expect(request.parameters?.contains(HTTPParameter(key: Constants.tokenKey, value: Constants.mockToken)) == true)
        #expect(request.parameters?.contains(HTTPParameter(key: "lastIncidentUniqueId", value: "42")) == true)
        #expect(request.parameters?.contains(HTTPParameter(key: "lastOpenDateTime", value: formatter.string(from: openDate))) == true)
        #expect(request.parameters?.contains(HTTPParameter(key: "tripDateTimeFrom", value: formatter.string(from: fromDate))) == true)
        #expect(request.parameters?.contains(HTTPParameter(key: "tripDateTimeTo", value: formatter.string(from: toDate))) == true)
    }
}

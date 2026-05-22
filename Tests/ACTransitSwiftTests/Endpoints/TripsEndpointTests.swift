@testable import ACTransitSwift
import EZNetworking
import Foundation
import Testing

@Suite("Test TripsEndpoint")
final class TripsEndpointTests {
    enum Constants {
        static let tokenKey = "token"
        static let mockToken = "mockToken"
    }

    @Test("test TripsEndpoint.canceled with no optional params")
    func canceled() {
        let endpoint = TripsEndpoint.canceled()
        let request = endpoint.getRequest(token: Constants.mockToken)

        #expect(endpoint.path == "/trips/canceled")
        #expect(request.httpMethod == .GET)
        #expect(request.baseUrl == "https://api.actransit.org/transit/trips/canceled")
        #expect(request.parameters == [HTTPParameter(key: Constants.tokenKey, value: Constants.mockToken)])
    }

    @Test("test TripsEndpoint.canceled includes optional params when provided")
    func canceledWithParams() {
        let openDate = Date(timeIntervalSince1970: 1_746_100_000)
        let fromDate = Date(timeIntervalSince1970: 1_746_200_000)
        let toDate = Date(timeIntervalSince1970: 1_746_300_000)
        let endpoint = TripsEndpoint.canceled(
            lastIncidentUniqueId: 42,
            lastOpenDateTime: openDate,
            tripDateTimeFrom: fromDate,
            tripDateTimeTo: toDate
        )
        let request = endpoint.getRequest(token: Constants.mockToken)

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

    @Test("test TripsEndpoint.cancellationInfo")
    func cancellationInfo() {
        let endpoint = TripsEndpoint.cancellationInfo(tripNumber: 1001)
        let request = endpoint.getRequest(token: Constants.mockToken)

        #expect(endpoint.path == "/trips/tripcancellationinfo/1001")
        #expect(request.httpMethod == .GET)
        #expect(request.baseUrl == "https://api.actransit.org/transit/trips/tripcancellationinfo/1001")
        #expect(request.parameters == [HTTPParameter(key: Constants.tokenKey, value: Constants.mockToken)])
    }
}

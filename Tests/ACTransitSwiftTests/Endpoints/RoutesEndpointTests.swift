@testable import ACTransitSwift
import EZNetworking
import Foundation
import Testing

@Suite("Test RoutesEndpoint")
final class RoutesEndpointTests {
    enum Constants {
        static let tokenKey = "token"
        static let mockToken = "mockToken"
    }

    @Test("test RoutesEndpoint.routes")
    func routes() {
        let endpoint = RoutesEndpoint.routes()
        let request = endpoint.getRequest(token: Constants.mockToken)

        #expect(endpoint.path == "/routes")
        #expect(request.httpMethod == .GET)
        #expect(request.baseUrl == "https://api.actransit.org/transit/routes")
        #expect((request.parameters ?? []).contains(HTTPParameter(key: Constants.tokenKey, value: Constants.mockToken)))
    }

    @Test("test RoutesEndpoint.routes with booking")
    func routesWithBooking() {
        let endpoint = RoutesEndpoint.routes(booking: "Current")
        let request = endpoint.getRequest(token: Constants.mockToken)

        #expect(endpoint.path == "/routes/Current")
        #expect(request.httpMethod == .GET)
        #expect(request.baseUrl == "https://api.actransit.org/transit/routes/Current")
        #expect((request.parameters ?? []).contains(HTTPParameter(key: Constants.tokenKey, value: Constants.mockToken)))
    }

    @Test("test RoutesEndpoint.trips")
    func trips() {
        let endpoint = RoutesEndpoint.trips(routeName: "72")
        let request = endpoint.getRequest(token: Constants.mockToken)

        #expect(endpoint.path == "/route/72/trips")
        #expect(request.httpMethod == .GET)
        #expect(request.baseUrl == "https://api.actransit.org/transit/route/72/trips")
        #expect((request.parameters ?? []).contains(HTTPParameter(key: Constants.tokenKey, value: Constants.mockToken)))
    }

    @Test("test RoutesEndpoint.trips with scheduleType")
    func tripsWithScheduleType() {
        let endpoint = RoutesEndpoint.trips(routeName: "72", scheduleType: .weekday)
        let request = endpoint.getRequest(token: Constants.mockToken)

        #expect(endpoint.path == "/route/72/trips")
        #expect((request.parameters ?? []).contains(HTTPParameter(key: "scheduleType", value: "Weekday")))
    }

    @Test("test RoutesEndpoint.route")
    func route() {
        let endpoint = RoutesEndpoint.route(routeName: "72")
        let request = endpoint.getRequest(token: Constants.mockToken)

        #expect(endpoint.path == "/route/72")
        #expect(request.httpMethod == .GET)
        #expect(request.baseUrl == "https://api.actransit.org/transit/route/72")
        #expect((request.parameters ?? []).contains(HTTPParameter(key: Constants.tokenKey, value: Constants.mockToken)))
    }

    @Test("test RoutesEndpoint.route with booking")
    func routeWithBooking() {
        let endpoint = RoutesEndpoint.route(routeName: "72", booking: "Current")
        let request = endpoint.getRequest(token: Constants.mockToken)

        #expect(endpoint.path == "/route/72/Current")
        #expect(request.baseUrl == "https://api.actransit.org/transit/route/72/Current")
    }

    @Test("test RoutesEndpoint.routes with sortType")
    func routesWithSortType() {
        let endpoint = RoutesEndpoint.routes(sortType: .alphabetical)
        let request = endpoint.getRequest(token: Constants.mockToken)

        #expect(endpoint.path == "/routes")
        #expect((request.parameters ?? []).contains(HTTPParameter(key: "sortType", value: "Alphabetical")))
    }
}

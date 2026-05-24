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

    @Test("test RoutesEndpoint.stops")
    func stops() {
        let endpoint = RoutesEndpoint.stops(routeName: "72")
        let request = endpoint.getRequest(token: Constants.mockToken)

        #expect(endpoint.path == "/route/72/stops")
        #expect(request.httpMethod == .GET)
        #expect(request.baseUrl == "https://api.actransit.org/transit/route/72/stops")
        #expect((request.parameters ?? []).contains(HTTPParameter(key: Constants.tokenKey, value: Constants.mockToken)))
    }

    @Test("test RoutesEndpoint.stops with booking")
    func stopsWithBooking() {
        let endpoint = RoutesEndpoint.stops(routeName: "72", booking: "Current")
        let request = endpoint.getRequest(token: Constants.mockToken)

        #expect(endpoint.path == "/route/72/stops/Current")
        #expect(request.baseUrl == "https://api.actransit.org/transit/route/72/stops/Current")
    }

    @Test("test RoutesEndpoint.directions")
    func directions() {
        let endpoint = RoutesEndpoint.directions(routeName: "72")
        let request = endpoint.getRequest(token: Constants.mockToken)

        #expect(endpoint.path == "/route/72/directions")
        #expect(request.httpMethod == .GET)
        #expect(request.baseUrl == "https://api.actransit.org/transit/route/72/directions")
        #expect(request.parameters == [HTTPParameter(key: Constants.tokenKey, value: Constants.mockToken)])
    }

    @Test("test RoutesEndpoint.tripsInstructions")
    func tripsInstructions() {
        let endpoint = RoutesEndpoint.tripsInstructions(routeName: "72", scheduleType: .weekday)
        let request = endpoint.getRequest(token: Constants.mockToken)

        #expect(endpoint.path == "/route/72/tripsinstructions")
        #expect(request.httpMethod == .GET)
        #expect(request.baseUrl == "https://api.actransit.org/transit/route/72/tripsinstructions")
        #expect((request.parameters ?? []).contains(HTTPParameter(key: "scheduleType", value: "Weekday")))
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

    @Test("test RoutesEndpoint.pattern")
    func pattern() {
        let endpoint = RoutesEndpoint.pattern(routeName: "72", tripId: 11_861_464)
        let request = endpoint.getRequest(token: Constants.mockToken)

        #expect(endpoint.path == "/route/72/trip/11861464/pattern")
        #expect(request.httpMethod == .GET)
        #expect(request.baseUrl == "https://api.actransit.org/transit/route/72/trip/11861464/pattern")
        #expect(request.parameters == [HTTPParameter(key: Constants.tokenKey, value: Constants.mockToken)])
    }

    @Test("test RoutesEndpoint.tripEstimate")
    func tripEstimate() {
        let endpoint = RoutesEndpoint.tripEstimate(routeName: "72", fromStopId: 55888, toStopId: 51632)
        let request = endpoint.getRequest(token: Constants.mockToken)

        #expect(endpoint.path == "/route/72/tripestimate")
        #expect(request.httpMethod == .GET)
        #expect(request.baseUrl == "https://api.actransit.org/transit/route/72/tripestimate")
        #expect((request.parameters ?? []).contains(HTTPParameter(key: Constants.tokenKey, value: Constants.mockToken)))
        #expect((request.parameters ?? []).contains(HTTPParameter(key: "fromStopId", value: "55888")))
        #expect((request.parameters ?? []).contains(HTTPParameter(key: "toStopId", value: "51632")))
    }

    @Test("test RoutesEndpoint.vehicles")
    func vehicles() {
        let endpoint = RoutesEndpoint.vehicles(routeName: "72")
        let request = endpoint.getRequest(token: Constants.mockToken)

        #expect(endpoint.path == "/route/72/vehicles")
        #expect(request.httpMethod == .GET)
        #expect(request.baseUrl == "https://api.actransit.org/transit/route/72/vehicles")
        #expect(request.parameters == [HTTPParameter(key: Constants.tokenKey, value: Constants.mockToken)])
    }

    @Test("test RoutesEndpoint.tripStops")
    func tripStops() {
        let endpoint = RoutesEndpoint.tripStops(routeName: "72", tripId: 11_861_464)
        let request = endpoint.getRequest(token: Constants.mockToken)

        #expect(endpoint.path == "/route/72/trip/11861464/stops")
        #expect(request.httpMethod == .GET)
        #expect(request.baseUrl == "https://api.actransit.org/transit/route/72/trip/11861464/stops")
        #expect(request.parameters == [HTTPParameter(key: Constants.tokenKey, value: Constants.mockToken)])
    }
}

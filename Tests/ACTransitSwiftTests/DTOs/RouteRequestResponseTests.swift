@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test RouteRequestResponse")
final class RouteRequestResponseTests {
    @Test("init stores routes and error")
    func initStoresRoutes() {
        let route = BusTimeRoute.sample
        let response = RouteRequestResponse(routes: [route], error: nil)
        #expect(response.routes.count == 1)
        #expect(response.routes[0].rt == route.rt)
        #expect(response.error == nil)
    }
}

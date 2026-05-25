@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test BusTimeRoute")
final class BusTimeRouteTests {
    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = BusTimeRoute.make(rt: "72")
        #expect(result.rt == "72")
        #expect(result.rtnm == BusTimeRoute.sample.rtnm)
        #expect(result.rtclr == BusTimeRoute.sample.rtclr)
        #expect(result.rtdd == BusTimeRoute.sample.rtdd)
        #expect(result.rtpidatafeed == BusTimeRoute.sample.rtpidatafeed)
    }

    @Test("RouteRequestResponse init stores routes and error")
    func routeRequestResponseInit() {
        let route = BusTimeRoute.sample
        let response = RouteRequestResponse(routes: [route], error: nil)
        #expect(response.routes.count == 1)
        #expect(response.routes[0].rt == route.rt)
        #expect(response.error == nil)
    }
}

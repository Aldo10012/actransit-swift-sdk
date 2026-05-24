@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test RouteStopOrder")
final class RouteStopOrderTests {
    @Test("StopOrder make() applies overrides independently")
    func stopOrderMakeOverrides() {
        let result = StopOrder.make(stopId: 99999)
        #expect(result.stopId == 99999)
        #expect(result.name == StopOrder.sample.name)
        #expect(result.latitude == StopOrder.sample.latitude)
        #expect(result.longitude == StopOrder.sample.longitude)
        #expect(result.order == StopOrder.sample.order)
    }

    @Test("RouteStopOrder make() applies overrides independently")
    func routeStopOrderMakeOverrides() {
        let result = RouteStopOrder.make(route: "51A")
        #expect(result.route == "51A")
        #expect(result.direction == RouteStopOrder.sample.direction)
        #expect(result.destination == RouteStopOrder.sample.destination)
        #expect(result.stops.count == RouteStopOrder.sample.stops.count)
    }
}

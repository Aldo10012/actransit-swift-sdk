@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test RouteStopOrder")
final class RouteStopOrderTests {
    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = RouteStopOrder.make(route: "51A")
        #expect(result.route == "51A")
        #expect(result.direction == RouteStopOrder.sample.direction)
        #expect(result.destination == RouteStopOrder.sample.destination)
        #expect(result.stops.count == RouteStopOrder.sample.stops.count)
    }
}

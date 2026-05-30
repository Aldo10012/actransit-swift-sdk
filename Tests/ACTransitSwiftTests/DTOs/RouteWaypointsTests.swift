@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test RouteWaypoints")
final class RouteWaypointsTests {
    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = RouteWaypoints.make(routeAlpha: "51")
        #expect(result.routeAlpha == "51")
        #expect(result.booking == RouteWaypoints.sample.booking)
        #expect(result.patterns.count == RouteWaypoints.sample.patterns.count)
    }
}

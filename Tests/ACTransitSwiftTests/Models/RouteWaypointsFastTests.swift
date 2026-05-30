@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test RouteWaypointsFast")
final class RouteWaypointsFastTests {
    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = RouteWaypointsFast.make(booking: "2605FA")
        #expect(result.booking == "2605FA")
        #expect(result.routeAlpha == RouteWaypointsFast.sample.routeAlpha)
        #expect(result.patterns.count == RouteWaypointsFast.sample.patterns.count)
    }
}

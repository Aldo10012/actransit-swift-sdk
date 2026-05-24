@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test RouteWaypointsFast")
final class RouteWaypointsFastTests {
    @Test("RoutePatternFast make() applies overrides independently")
    func routePatternFastMakeOverrides() {
        let result = RoutePatternFast.make(directionId: 6)
        #expect(result.directionId == 6)
        #expect(result.direction == RoutePatternFast.sample.direction)
        #expect(result.destination == RoutePatternFast.sample.destination)
        #expect(result.firstPlaceId == RoutePatternFast.sample.firstPlaceId)
        #expect(result.lastPlaceId == RoutePatternFast.sample.lastPlaceId)
        #expect(result.isDefault == RoutePatternFast.sample.isDefault)
        #expect(result.totalDistance == RoutePatternFast.sample.totalDistance)
        #expect(result.waypoints == RoutePatternFast.sample.waypoints)
    }

    @Test("RouteWaypointsFast make() applies overrides independently")
    func routeWaypointsFastMakeOverrides() {
        let result = RouteWaypointsFast.make(booking: "2605FA")
        #expect(result.booking == "2605FA")
        #expect(result.routeAlpha == RouteWaypointsFast.sample.routeAlpha)
        #expect(result.patterns.count == RouteWaypointsFast.sample.patterns.count)
    }
}

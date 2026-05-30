@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test RoutePatternFast")
final class RoutePatternFastTests {
    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
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
}

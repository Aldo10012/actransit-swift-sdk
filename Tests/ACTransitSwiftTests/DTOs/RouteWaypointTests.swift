@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test RouteWaypoint")
final class RouteWaypointTests {
    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = RouteWaypoint.make(orderId: 99)
        #expect(result.orderId == 99)
        #expect(result.latitude == RouteWaypoint.sample.latitude)
        #expect(result.longitude == RouteWaypoint.sample.longitude)
        #expect(result.heading == RouteWaypoint.sample.heading)
        #expect(result.distanceToNextStop == RouteWaypoint.sample.distanceToNextStop)
        #expect(result.distanceFromStart == RouteWaypoint.sample.distanceFromStart)
        #expect(result.stopSequence == RouteWaypoint.sample.stopSequence)
    }
}

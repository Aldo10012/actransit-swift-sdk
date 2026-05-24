@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test RouteWaypoints")
final class RouteWaypointsTests {
    @Test("RouteWaypoint make() applies overrides independently")
    func routeWaypointMakeOverrides() {
        let result = RouteWaypoint.make(orderId: 99)
        #expect(result.orderId == 99)
        #expect(result.latitude == RouteWaypoint.sample.latitude)
        #expect(result.longitude == RouteWaypoint.sample.longitude)
        #expect(result.heading == RouteWaypoint.sample.heading)
        #expect(result.distanceToNextStop == RouteWaypoint.sample.distanceToNextStop)
        #expect(result.distanceFromStart == RouteWaypoint.sample.distanceFromStart)
        #expect(result.stopSequence == RouteWaypoint.sample.stopSequence)
    }

    @Test("RoutePattern make() applies overrides independently")
    func routePatternMakeOverrides() {
        let result = RoutePattern.make(directionId: 6)
        #expect(result.directionId == 6)
        #expect(result.direction == RoutePattern.sample.direction)
        #expect(result.destination == RoutePattern.sample.destination)
        #expect(result.firstPlaceId == RoutePattern.sample.firstPlaceId)
        #expect(result.lastPlaceId == RoutePattern.sample.lastPlaceId)
        #expect(result.isDefault == RoutePattern.sample.isDefault)
        #expect(result.totalDistance == RoutePattern.sample.totalDistance)
    }

    @Test("RouteWaypoints make() applies overrides independently")
    func routeWaypointsMakeOverrides() {
        let result = RouteWaypoints.make(routeAlpha: "51")
        #expect(result.routeAlpha == "51")
        #expect(result.booking == RouteWaypoints.sample.booking)
        #expect(result.patterns.count == RouteWaypoints.sample.patterns.count)
    }
}

@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test StopRouteDestination")
final class StopRouteDestinationTests {
    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = StopRouteDestination.make(routeId: "51A")
        #expect(result.routeId == "51A")
        #expect(result.directionId == StopRouteDestination.sample.directionId)
        #expect(result.direction == StopRouteDestination.sample.direction)
        #expect(result.destination == StopRouteDestination.sample.destination)
        #expect(result.finalPassingTime == StopRouteDestination.sample.finalPassingTime)
        #expect(result.status == StopRouteDestination.sample.status)
    }
}

@Suite("Test StopDestination")
final class StopDestinationTests {
    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = StopDestination.make(stopId: 99999)
        #expect(result.stopId == 99999)
        #expect(result.status == StopDestination.sample.status)
        #expect(result.routeDestinations.count == StopDestination.sample.routeDestinations.count)
    }
}

@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test RouteDestination")
final class RouteDestinationTests {
    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = RouteDestination.make(routeId: "1T")
        #expect(result.routeId == "1T")
        #expect(result.directionId == RouteDestination.sample.directionId)
        #expect(result.direction == RouteDestination.sample.direction)
        #expect(result.destination == RouteDestination.sample.destination)
    }
}

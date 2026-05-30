@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test RoutePattern")
final class RoutePatternTests {
    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = RoutePattern.make(directionId: 6)
        #expect(result.directionId == 6)
        #expect(result.direction == RoutePattern.sample.direction)
        #expect(result.destination == RoutePattern.sample.destination)
        #expect(result.firstPlaceId == RoutePattern.sample.firstPlaceId)
        #expect(result.lastPlaceId == RoutePattern.sample.lastPlaceId)
        #expect(result.isDefault == RoutePattern.sample.isDefault)
        #expect(result.totalDistance == RoutePattern.sample.totalDistance)
    }
}

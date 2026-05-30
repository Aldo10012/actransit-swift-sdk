@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test TripScheduleRoute")
final class TripScheduleRouteTests {
    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = TripScheduleRoute.make(routeId: "51A")
        #expect(result.routeId == "51A")
        #expect(result.lineDirection == TripScheduleRoute.sample.lineDirection)
        #expect(result.lineDestination == TripScheduleRoute.sample.lineDestination)
        #expect(result.dayCode == TripScheduleRoute.sample.dayCode)
        #expect(result.operatingDOW == TripScheduleRoute.sample.operatingDOW)
        #expect(result.trips.count == TripScheduleRoute.sample.trips.count)
    }
}

@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test TripStopToday")
final class TripStopTodayTests {
    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = TripStopToday.make(routeId: "51A")
        #expect(result.routeId == "51A")
        #expect(result.directionId == TripStopToday.sample.directionId)
        #expect(result.direction == TripStopToday.sample.direction)
        #expect(result.scheduleType == TripStopToday.sample.scheduleType)
        #expect(result.tripId == TripStopToday.sample.tripId)
        #expect(result.stopId == TripStopToday.sample.stopId)
    }
}

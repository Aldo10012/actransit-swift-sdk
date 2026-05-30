@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test TripScheduleStopTime")
final class TripScheduleStopTimeTests {
    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = TripScheduleStopTime.make(stopTime: "06:00:00")
        #expect(result.stopTime == "06:00:00")
        #expect(result.stopId == TripScheduleStopTime.sample.stopId)
        #expect(result.placeId == TripScheduleStopTime.sample.placeId)
        #expect(result.occupancy == TripScheduleStopTime.sample.occupancy)
    }
}

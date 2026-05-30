@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test TripScheduleTrip")
final class TripScheduleTripTests {
    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = TripScheduleTrip.make(startTime: "06:00:00")
        #expect(result.startTime == "06:00:00")
        #expect(result.patternId == TripScheduleTrip.sample.patternId)
        #expect(result.tripId == TripScheduleTrip.sample.tripId)
        #expect(result.status == TripScheduleTrip.sample.status)
        #expect(result.stopTimes.count == TripScheduleTrip.sample.stopTimes.count)
    }
}

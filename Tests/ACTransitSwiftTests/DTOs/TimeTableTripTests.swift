@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test TimeTableTrip")
final class TimeTableTripTests {
    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = TimeTableTrip.make(tripId: 99999)
        #expect(result.tripId == 99999)
        #expect(result.tripStartTime == TimeTableTrip.sample.tripStartTime)
        #expect(result.tripDestination == TimeTableTrip.sample.tripDestination)
        #expect(result.tripStops.count == TimeTableTrip.sample.tripStops.count)
    }
}

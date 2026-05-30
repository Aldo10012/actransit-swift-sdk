@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test TimeTableTripStop")
final class TimeTableTripStopTests {
    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = TimeTableTripStop.make(stopId: 99999)
        #expect(result.stopId == 99999)
        #expect(result.passingTime == TimeTableTripStop.sample.passingTime)
    }
}

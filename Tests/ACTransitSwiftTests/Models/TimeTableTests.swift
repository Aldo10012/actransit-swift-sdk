@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test TimeTable")
final class TimeTableTests {
    @Test("TimeTableTripStop make() applies overrides independently")
    func timeTableTripStopMakeOverrides() {
        let result = TimeTableTripStop.make(stopId: 99999)
        #expect(result.stopId == 99999)
        #expect(result.passingTime == TimeTableTripStop.sample.passingTime)
    }
}

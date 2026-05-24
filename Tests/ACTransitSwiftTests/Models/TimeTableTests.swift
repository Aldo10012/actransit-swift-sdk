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

    @Test("TimeTableStop make() applies overrides independently")
    func timeTableStopMakeOverrides() {
        let result = TimeTableStop.make(stopId: 99999)
        #expect(result.stopId == 99999)
        #expect(result.stopDescription == TimeTableStop.sample.stopDescription)
        #expect(result.placeId == TimeTableStop.sample.placeId)
        #expect(result.stopLongitude == TimeTableStop.sample.stopLongitude)
        #expect(result.stopLatitude == TimeTableStop.sample.stopLatitude)
    }
}

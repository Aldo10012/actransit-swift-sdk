@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test TimeTableStop")
final class TimeTableStopTests {
    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = TimeTableStop.make(stopId: 99999)
        #expect(result.stopId == 99999)
        #expect(result.stopDescription == TimeTableStop.sample.stopDescription)
        #expect(result.placeId == TimeTableStop.sample.placeId)
        #expect(result.stopLongitude == TimeTableStop.sample.stopLongitude)
        #expect(result.stopLatitude == TimeTableStop.sample.stopLatitude)
    }
}

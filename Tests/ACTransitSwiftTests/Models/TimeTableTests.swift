@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test TimeTable")
final class TimeTableTests {
    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = TimeTable.make(routeId: "51")
        #expect(result.routeId == "51")
        #expect(result.bookingId == TimeTable.sample.bookingId)
        #expect(result.destination == TimeTable.sample.destination)
        #expect(result.direction == TimeTable.sample.direction)
        #expect(result.dayCode == TimeTable.sample.dayCode)
    }
}

@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test TimePoint")
final class TimePointTests {
    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = TimePoint.make(tripId: 99999)
        #expect(result.tripId == 99999)
        #expect(result.sequence == TimePoint.sample.sequence)
        #expect(result.latitude == TimePoint.sample.latitude)
        #expect(result.longitude == TimePoint.sample.longitude)
    }
}

@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test Trip")
final class TripTests {
    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = Trip.make(tripId: 99999)
        #expect(result.tripId == 99999)
        #expect(result.routeName == Trip.sample.routeName)
        #expect(result.scheduleType == Trip.sample.scheduleType)
        #expect(result.startTime == Trip.sample.startTime)
        #expect(result.direction == Trip.sample.direction)
    }
}

@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test TripScheduleInfo")
final class TripScheduleInfoTests {
    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = TripScheduleInfo.make(bookingId: "2605FA")
        #expect(result.bookingId == "2605FA")
        #expect(result.routeProfiles.count == TripScheduleInfo.sample.routeProfiles.count)
        #expect(result.stops.count == TripScheduleInfo.sample.stops.count)
        #expect(result.routes.count == TripScheduleInfo.sample.routes.count)
    }
}

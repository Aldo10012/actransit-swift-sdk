@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test TripScheduleStop")
final class TripScheduleStopTests {
    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = TripScheduleStop.make(stopId: "99999")
        #expect(result.stopId == "99999")
        #expect(result.placeName == TripScheduleStop.sample.placeName)
        #expect(result.placeId == TripScheduleStop.sample.placeId)
        #expect(result.stopDescription == TripScheduleStop.sample.stopDescription)
        #expect(result.longitude == TripScheduleStop.sample.longitude)
        #expect(result.latitude == TripScheduleStop.sample.latitude)
        #expect(result.city == TripScheduleStop.sample.city)
    }
}

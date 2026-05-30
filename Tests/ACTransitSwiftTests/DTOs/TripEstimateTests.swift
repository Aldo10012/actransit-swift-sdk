@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test TripEstimate")
final class TripEstimateTests {
    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = TripEstimate.make(routeName: "51A")
        #expect(result.routeName == "51A")
        #expect(result.originStopId == TripEstimate.sample.originStopId)
        #expect(result.destinationStopId == TripEstimate.sample.destinationStopId)
        #expect(result.expectedDepartureTime == TripEstimate.sample.expectedDepartureTime)
        #expect(result.tripDuration == TripEstimate.sample.tripDuration)
    }
}

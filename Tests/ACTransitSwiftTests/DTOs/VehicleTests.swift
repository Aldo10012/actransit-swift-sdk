@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test Vehicle")
final class VehicleTests {
    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = Vehicle.make(vehicleId: 9999)
        #expect(result.vehicleId == 9999)
        #expect(result.currentTripId == Vehicle.sample.currentTripId)
        #expect(result.latitude == Vehicle.sample.latitude)
        #expect(result.longitude == Vehicle.sample.longitude)
        #expect(result.heading == Vehicle.sample.heading)
        #expect(result.timeLastReported == Vehicle.sample.timeLastReported)
    }
}

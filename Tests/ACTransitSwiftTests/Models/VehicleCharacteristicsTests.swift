@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test VehicleCharacteristics")
final class VehicleCharacteristicsTests {
    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = VehicleCharacteristics.make(vehicleId: "9999")
        #expect(result.vehicleId == "9999")
        #expect(result.isActive == VehicleCharacteristics.sample.isActive)
        #expect(result.description == VehicleCharacteristics.sample.description)
        #expect(result.make == VehicleCharacteristics.sample.make)
        #expect(result.propulsionType == VehicleCharacteristics.sample.propulsionType)
        #expect(result.hasWiFi == VehicleCharacteristics.sample.hasWiFi)
        #expect(result.hasAC == VehicleCharacteristics.sample.hasAC)
        #expect(result.limitCapacity == VehicleCharacteristics.sample.limitCapacity)
    }
}

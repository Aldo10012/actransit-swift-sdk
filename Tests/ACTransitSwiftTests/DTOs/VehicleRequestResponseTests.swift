@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test VehicleRequestResponse")
final class VehicleRequestResponseTests {
    @Test("init stores vehicles and error")
    func initStoresVehicles() {
        let vehicle = BusTimeVehicle.sample
        let error = BusTimeError(msg: "test error")
        let response = VehicleRequestResponse(vehicle: [vehicle], error: [error])
        #expect(response.vehicle.count == 1)
        #expect(response.vehicle[0].vid == vehicle.vid)
        #expect(response.error?.count == 1)
        #expect(response.error?[0].msg == "test error")
    }

    @Test("init with nil error")
    func initWithNilError() {
        let response = VehicleRequestResponse(vehicle: [])
        #expect(response.vehicle.isEmpty)
        #expect(response.error == nil)
    }
}

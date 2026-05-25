@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test BusTimeVehicle")
final class BusTimeVehicleTests {
    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = BusTimeVehicle.make(vid: "9999")
        #expect(result.vid == "9999")
        #expect(result.tmstmp == BusTimeVehicle.sample.tmstmp)
        #expect(result.lat == BusTimeVehicle.sample.lat)
        #expect(result.lon == BusTimeVehicle.sample.lon)
        #expect(result.hdg == BusTimeVehicle.sample.hdg)
        #expect(result.pid == BusTimeVehicle.sample.pid)
        #expect(result.pdist == BusTimeVehicle.sample.pdist)
        #expect(result.rt == BusTimeVehicle.sample.rt)
        #expect(result.des == BusTimeVehicle.sample.des)
        #expect(result.dly == BusTimeVehicle.sample.dly)
        #expect(result.rtpidatafeed == BusTimeVehicle.sample.rtpidatafeed)
        #expect(result.tmres == BusTimeVehicle.sample.tmres)
    }

    @Test("VehicleRequestResponse init stores vehicles and error")
    func vehicleRequestResponseInit() {
        let vehicle = BusTimeVehicle.sample
        let error = BusTimeError(msg: "test error")
        let response = VehicleRequestResponse(vehicle: [vehicle], error: [error])
        #expect(response.vehicle.count == 1)
        #expect(response.vehicle[0].vid == vehicle.vid)
        #expect(response.error?.count == 1)
        #expect(response.error?[0].msg == "test error")
    }

    @Test("VehicleRequestResponse init with nil error")
    func vehicleRequestResponseNilError() {
        let response = VehicleRequestResponse(vehicle: [])
        #expect(response.vehicle.isEmpty)
        #expect(response.error == nil)
    }
}

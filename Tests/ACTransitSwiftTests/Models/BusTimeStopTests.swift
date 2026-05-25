@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test BusTimeStop")
final class BusTimeStopTests {
    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = BusTimeStop.make(stpid: "99999")
        #expect(result.stpid == "99999")
        #expect(result.stpnm == BusTimeStop.sample.stpnm)
        #expect(result.lat == BusTimeStop.sample.lat)
        #expect(result.lon == BusTimeStop.sample.lon)
        #expect(result.dtradd == BusTimeStop.sample.dtradd)
        #expect(result.dtrrem == BusTimeStop.sample.dtrrem)
    }

    @Test("StopRequestResponse init stores stops and error")
    func stopRequestResponseInit() {
        let stop = BusTimeStop.sample
        let response = StopRequestResponse(stops: [stop], error: nil)
        #expect(response.stops.count == 1)
        #expect(response.stops[0].stpid == stop.stpid)
        #expect(response.error == nil)
    }
}

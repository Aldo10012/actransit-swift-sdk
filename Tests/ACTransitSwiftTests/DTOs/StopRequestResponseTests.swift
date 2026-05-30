@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test StopRequestResponse")
final class StopRequestResponseTests {
    @Test("init stores stops and error")
    func initStoresStops() {
        let stop = BusTimeStop.sample
        let response = StopRequestResponse(stops: [stop], error: nil)
        #expect(response.stops.count == 1)
        #expect(response.stops[0].stpid == stop.stpid)
        #expect(response.error == nil)
    }
}

@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test BusTimeError")
final class BusTimeErrorTests {
    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = BusTimeError.make(msg: "custom error")
        #expect(result.msg == "custom error")
        #expect(result.rtpidatafeed == BusTimeError.sample.rtpidatafeed)
        #expect(result.stpid == BusTimeError.sample.stpid)
        #expect(result.rt == BusTimeError.sample.rt)
        #expect(result.vid == BusTimeError.sample.vid)
    }
}

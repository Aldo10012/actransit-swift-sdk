@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test ServiceBulletin")
final class ServiceBulletinTests {
    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = ServiceBulletin.make(rt: "72")
        #expect(result.rt == "72")
        #expect(result.rtdir == ServiceBulletin.sample.rtdir)
        #expect(result.stpid == ServiceBulletin.sample.stpid)
        #expect(result.stpnm == ServiceBulletin.sample.stpnm)
    }
}

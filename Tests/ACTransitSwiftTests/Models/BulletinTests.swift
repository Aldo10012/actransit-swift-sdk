@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test Bulletin")
final class BulletinTests {
    @Test("ServiceBulletin make() applies overrides independently")
    func serviceBulletinMakeOverridesIndependently() {
        let result = ServiceBulletin.make(rt: "72")
        #expect(result.rt == "72")
        #expect(result.rtdir == ServiceBulletin.sample.rtdir)
        #expect(result.stpid == ServiceBulletin.sample.stpid)
        #expect(result.stpnm == ServiceBulletin.sample.stpnm)
    }

    @Test("Bulletin make() applies overrides independently")
    func bulletinMakeOverridesIndependently() {
        let result = Bulletin.make(nm: "SB-2024-001")
        #expect(result.nm == "SB-2024-001")
        #expect(result.sbj == Bulletin.sample.sbj)
        #expect(result.prty == Bulletin.sample.prty)
        #expect(result.mod == Bulletin.sample.mod)
    }

    @Test("ServiceBulletinRequestResponse init stores bulletins and error")
    func serviceBulletinRequestResponseInit() {
        let bulletin = Bulletin.sample
        let response = ServiceBulletinRequestResponse(sb: [bulletin], error: nil)
        #expect(response.sb.count == 1)
        #expect(response.sb[0].nm == bulletin.nm)
        #expect(response.error == nil)
    }
}

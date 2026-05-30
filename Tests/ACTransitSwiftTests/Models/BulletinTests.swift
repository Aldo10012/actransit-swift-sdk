@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test Bulletin")
final class BulletinTests {
    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = Bulletin.make(nm: "SB-2024-001")
        #expect(result.nm == "SB-2024-001")
        #expect(result.sbj == Bulletin.sample.sbj)
        #expect(result.prty == Bulletin.sample.prty)
        #expect(result.mod == Bulletin.sample.mod)
    }
}

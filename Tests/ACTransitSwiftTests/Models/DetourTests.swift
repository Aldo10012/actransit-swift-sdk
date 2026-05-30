@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test Detour")
final class DetourTests {
    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = Detour.make(id: "9999")
        #expect(result.id == "9999")
        #expect(result.ver == Detour.sample.ver)
        #expect(result.st == Detour.sample.st)
        #expect(result.desc == Detour.sample.desc)
        #expect(result.startdt == Detour.sample.startdt)
        #expect(result.enddt == Detour.sample.enddt)
    }
}

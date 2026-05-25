@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test Detour")
final class DetourTests {
    @Test("RtDir make() applies overrides independently")
    func rtDirMakeOverridesIndependently() {
        let result = RtDir.make(rt: "72")
        #expect(result.rt == "72")
        #expect(result.dir == RtDir.sample.dir)
    }

    @Test("Detour make() applies overrides independently")
    func detourMakeOverridesIndependently() {
        let result = Detour.make(id: "9999")
        #expect(result.id == "9999")
        #expect(result.ver == Detour.sample.ver)
        #expect(result.st == Detour.sample.st)
        #expect(result.desc == Detour.sample.desc)
        #expect(result.startdt == Detour.sample.startdt)
        #expect(result.enddt == Detour.sample.enddt)
    }

    @Test("DetourRequestResponse init stores detours and error")
    func detourRequestResponseInit() {
        let detour = Detour.sample
        let response = DetourRequestResponse(dtrs: [detour], error: nil)
        #expect(response.dtrs.count == 1)
        #expect(response.dtrs[0].id == detour.id)
        #expect(response.error == nil)
    }
}

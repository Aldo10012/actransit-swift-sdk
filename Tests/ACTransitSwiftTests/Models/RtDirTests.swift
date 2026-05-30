@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test RtDir")
final class RtDirTests {
    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = RtDir.make(rt: "72")
        #expect(result.rt == "72")
        #expect(result.dir == RtDir.sample.dir)
    }
}

@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test PatternPoint")
final class PatternPointTests {
    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = PatternPoint.make(seq: 99)
        #expect(result.seq == 99)
        #expect(result.typ == PatternPoint.sample.typ)
        #expect(result.stpid == PatternPoint.sample.stpid)
        #expect(result.stpnm == PatternPoint.sample.stpnm)
        #expect(result.pdist == PatternPoint.sample.pdist)
        #expect(result.lat == PatternPoint.sample.lat)
        #expect(result.lon == PatternPoint.sample.lon)
    }
}

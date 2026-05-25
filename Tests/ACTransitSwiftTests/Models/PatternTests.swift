@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test Pattern")
final class PatternTests {
    @Test("PatternPoint make() applies overrides independently")
    func patternPointMakeOverridesIndependently() {
        let result = PatternPoint.make(seq: 99)
        #expect(result.seq == 99)
        #expect(result.typ == PatternPoint.sample.typ)
        #expect(result.stpid == PatternPoint.sample.stpid)
        #expect(result.stpnm == PatternPoint.sample.stpnm)
        #expect(result.pdist == PatternPoint.sample.pdist)
        #expect(result.lat == PatternPoint.sample.lat)
        #expect(result.lon == PatternPoint.sample.lon)
    }

    @Test("Pattern make() applies overrides independently")
    func patternMakeOverridesIndependently() {
        let result = Pattern.make(pid: 99999)
        #expect(result.pid == 99999)
        #expect(result.ln == Pattern.sample.ln)
        #expect(result.rtdir == Pattern.sample.rtdir)
        #expect(result.dtrid == Pattern.sample.dtrid)
        #expect(result.dtrpt == nil)
    }

    @Test("PatternRequestResponse init stores patterns and error")
    func patternRequestResponseInit() {
        let pattern = Pattern.sample
        let response = PatternRequestResponse(ptr: [pattern], error: nil)
        #expect(response.ptr.count == 1)
        #expect(response.ptr[0].pid == pattern.pid)
        #expect(response.error == nil)
    }
}

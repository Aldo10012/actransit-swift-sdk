@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test PatternRequestResponse")
final class PatternRequestResponseTests {
    @Test("init stores patterns and error")
    func initStoresPatterns() {
        let pattern = Pattern.sample
        let response = PatternRequestResponse(ptr: [pattern], error: nil)
        #expect(response.ptr.count == 1)
        #expect(response.ptr[0].pid == pattern.pid)
        #expect(response.error == nil)
    }
}

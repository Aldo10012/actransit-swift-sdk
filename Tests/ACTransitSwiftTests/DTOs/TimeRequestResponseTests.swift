@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test TimeRequestResponse")
final class TimeRequestResponseTests {
    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = TimeRequestResponse.make(tm: "20240101 00:00:00")
        #expect(result.tm == "20240101 00:00:00")
        #expect(result.error == nil)
    }
}

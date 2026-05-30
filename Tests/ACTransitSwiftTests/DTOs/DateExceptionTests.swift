@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test DateException")
final class DateExceptionTests {
    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = DateException.make(routeId: "51A")
        #expect(result.routeId == "51A")
        #expect(result.serviceExceptions.count == DateException.sample.serviceExceptions.count)
    }
}

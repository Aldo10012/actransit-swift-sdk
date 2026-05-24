@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test RouteExceptions")
final class RouteExceptionsTests {
    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = RouteExceptions.make(bookingId: "2605FA")
        #expect(result.bookingId == "2605FA")
        #expect(result.dateExceptions.count == RouteExceptions.sample.dateExceptions.count)
    }
}

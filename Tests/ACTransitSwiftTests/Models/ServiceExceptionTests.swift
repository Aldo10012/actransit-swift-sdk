@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test ServiceException")
final class ServiceExceptionTests {
    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = ServiceException.make(exceptionCode: "EX999")
        #expect(result.exceptionCode == "EX999")
        #expect(result.patternId == ServiceException.sample.patternId)
        #expect(result.tripId == ServiceException.sample.tripId)
        #expect(result.operatingDays == ServiceException.sample.operatingDays)
        #expect(result.exceptionDates == ServiceException.sample.exceptionDates)
        #expect(result.exceptionNotices == ServiceException.sample.exceptionNotices)
    }
}

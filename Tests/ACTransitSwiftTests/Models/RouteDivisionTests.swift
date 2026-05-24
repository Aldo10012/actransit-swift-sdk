@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test RouteDivision")
final class RouteDivisionTests {
    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = RouteDivision.make(routeId: "72")
        #expect(result.routeId == "72")
        #expect(result.name == RouteDivision.sample.name)
        #expect(result.division == RouteDivision.sample.division)
        #expect(result.description == RouteDivision.sample.description)
        #expect(result.isLocal == RouteDivision.sample.isLocal)
        #expect(result.isTransbay == RouteDivision.sample.isTransbay)
        #expect(result.isRapid == RouteDivision.sample.isRapid)
        #expect(result.isAllNighter == RouteDivision.sample.isAllNighter)
        #expect(result.isSchool == RouteDivision.sample.isSchool)
    }
}

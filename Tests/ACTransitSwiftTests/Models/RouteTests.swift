@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test Route")
final class RouteTests {
    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = Route.make(routeId: "1T")
        #expect(result.routeId == "1T")
        #expect(result.name == Route.sample.name)
        #expect(result.description == Route.sample.description)
    }
}

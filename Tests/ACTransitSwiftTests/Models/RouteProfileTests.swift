@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test RouteProfile")
final class RouteProfileTests {
    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = RouteProfile.make(routeId: "1T")
        #expect(result.routeId == "1T")
        #expect(result.profile == RouteProfile.sample.profile)
    }
}

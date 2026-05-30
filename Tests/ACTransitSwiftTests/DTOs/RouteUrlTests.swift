@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test RouteUrl")
final class RouteUrlTests {
    @Test("decodes from JSON")
    func decodesFromJSON() throws {
        let json = """
        { "RouteId": "72", "Url": "https://511.org/transit/schedules/72" }
        """
        let result = try JSONDecoder().decode(RouteUrl.self, from: Data(json.utf8))
        #expect(result.routeId == "72")
        #expect(result.url == "https://511.org/transit/schedules/72")
    }

    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = RouteUrl.make(routeId: "51A")
        #expect(result.routeId == "51A")
        #expect(result.url == RouteUrl.sample.url)
    }
}

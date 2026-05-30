@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test InfoUrl")
final class InfoUrlTests {
    @Test("decodes from JSON")
    func decodesFromJSON() throws {
        let json = """
        { "Url": "https://511.org/transit/alerts" }
        """
        let result = try JSONDecoder().decode(InfoUrl.self, from: Data(json.utf8))
        #expect(result.url == "https://511.org/transit/alerts")
    }

    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = InfoUrl.make(url: "https://example.com/custom")
        #expect(result.url == "https://example.com/custom")
    }
}

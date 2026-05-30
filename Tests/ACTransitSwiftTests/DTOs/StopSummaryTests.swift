@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test StopSummary")
final class StopSummaryTests {
    // MARK: - Decoding

    @Test("decodes happy path")
    func decodesHappyPath() throws {
        let json = """
        {
            "Count": 4850,
            "LastUpdatedDateTime": "2026-05-24T00:00:00.000-07:00"
        }
        """
        let result = try decode(json)
        #expect(result.count == 4850)
        #expect(result.lastUpdatedDateTime != nil)
    }

    @Test("decodes LastUpdatedDateTime with 7 fractional-second digits")
    func decodesSevenFractionalDigits() throws {
        let json = """
        {
            "Count": 4850,
            "LastUpdatedDateTime": "2026-05-24T00:00:00.8019863-07:00"
        }
        """
        let result = try decode(json)
        #expect(result.lastUpdatedDateTime != nil)
    }

    @Test("throws on malformed LastUpdatedDateTime")
    func throwsOnMalformedDate() {
        let json = """
        {
            "Count": 4850,
            "LastUpdatedDateTime": "not-a-date"
        }
        """
        #expect(throws: DecodingError.self) {
            try decode(json)
        }
    }

    // MARK: - Encoding

    @Test("encodes to PascalCase JSON keys")
    func encodesToPascalCaseKeys() throws {
        let encoded = try JSONEncoder().encode(StopSummary.sample)
        let dict = try JSONSerialization.jsonObject(with: encoded) as? [String: Any]
        #expect(dict?["Count"] != nil)
        #expect(dict?["LastUpdatedDateTime"] != nil)
    }

    @Test("round-trips encode → decode")
    func roundTrip() throws {
        let original = StopSummary.sample
        let encoded = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(StopSummary.self, from: encoded)
        #expect(decoded.count == original.count)
        #expect(decoded.lastUpdatedDateTime == original.lastUpdatedDateTime)
    }

    // MARK: - Mock Data

    @Test("sample has expected values")
    func sampleSanityCheck() {
        #expect(StopSummary.sample.count == 4850)
        #expect(StopSummary.sample.lastUpdatedDateTime != .distantPast)
    }

    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = StopSummary.make(count: 9999)
        #expect(result.count == 9999)
        #expect(result.lastUpdatedDateTime == StopSummary.sample.lastUpdatedDateTime)
    }

    // MARK: - Helpers

    private func decode(_ json: String) throws -> StopSummary {
        try JSONDecoder().decode(StopSummary.self, from: Data(json.utf8))
    }
}

@testable import ACTransitSwift
import Foundation
import Testing

@Suite("GtfsScheduleInfo")
final class GtfsScheduleInfoTests {

    // MARK: - Decoding

    @Test("decodes standard ISO 8601 response")
    func decodesStandardResponse() throws {
        let json = """
        {
            "UpdatedDate": "2025-05-01T12:00:00.000-07:00",
            "EarliestServiceDate": "2025-04-28T00:00:00.000-07:00",
            "LatestServiceDate": "2025-08-31T00:00:00.000-07:00"
        }
        """
        let result = try decode(json)
        #expect(result.updatedDate == GtfsScheduleInfo.sample.updatedDate)
        #expect(result.earliestServiceDate == GtfsScheduleInfo.sample.earliestServiceDate)
        #expect(result.latestServiceDate == GtfsScheduleInfo.sample.latestServiceDate)
    }

    @Test("decodes API response with 7 fractional-second digits")
    func decodesSevenFractionalDigits() throws {
        let json = """
        {
            "UpdatedDate": "2026-05-18T15:20:54.1878974-07:00",
            "EarliestServiceDate": "2026-05-18T15:20:54.1878974-07:00",
            "LatestServiceDate": "2026-05-18T15:20:54.1878974-07:00"
        }
        """
        let result = try decode(json)
        #expect(result.updatedDate == result.earliestServiceDate)
        #expect(result.earliestServiceDate == result.latestServiceDate)
    }

    @Test("throws on malformed date string")
    func throwsOnMalformedDate() {
        let json = """
        {
            "UpdatedDate": "not-a-date",
            "EarliestServiceDate": "2025-04-28T00:00:00.000-07:00",
            "LatestServiceDate": "2025-08-31T00:00:00.000-07:00"
        }
        """
        #expect(throws: DecodingError.self) {
            try decode(json)
        }
    }

    @Test("throws on missing required key")
    func throwsOnMissingKey() {
        let json = """
        {
            "UpdatedDate": "2025-05-01T12:00:00.000-07:00"
        }
        """
        #expect(throws: DecodingError.self) {
            try decode(json)
        }
    }

    // MARK: - Encoding

    @Test("encodes to PascalCase JSON keys")
    func encodesToPascalCaseKeys() throws {
        let encoded = try JSONEncoder().encode(GtfsScheduleInfo.sample)
        let dict = try JSONSerialization.jsonObject(with: encoded) as? [String: Any]
        #expect(dict?["UpdatedDate"] != nil)
        #expect(dict?["EarliestServiceDate"] != nil)
        #expect(dict?["LatestServiceDate"] != nil)
    }

    @Test("round-trips encode → decode without losing dates")
    func roundTrip() throws {
        let original = GtfsScheduleInfo.sample
        let encoded = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(GtfsScheduleInfo.self, from: encoded)
        #expect(decoded.updatedDate == original.updatedDate)
        #expect(decoded.earliestServiceDate == original.earliestServiceDate)
        #expect(decoded.latestServiceDate == original.latestServiceDate)
    }

    // MARK: - Mock Data

    @Test("sample has latestServiceDate after earliestServiceDate")
    func sampleDatesAreOrdered() {
        #expect(GtfsScheduleInfo.sample.latestServiceDate > GtfsScheduleInfo.sample.earliestServiceDate)
    }

    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let overrideDate = Date.distantFuture
        let result = GtfsScheduleInfo.make(updatedDate: overrideDate)
        #expect(result.updatedDate == overrideDate)
        #expect(result.earliestServiceDate == GtfsScheduleInfo.sample.earliestServiceDate)
        #expect(result.latestServiceDate == GtfsScheduleInfo.sample.latestServiceDate)
    }

    // MARK: - Helpers

    private func decode(_ json: String) throws -> GtfsScheduleInfo {
        try JSONDecoder().decode(GtfsScheduleInfo.self, from: Data(json.utf8))
    }
}

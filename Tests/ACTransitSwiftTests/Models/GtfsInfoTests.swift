@testable import ACTransitSwift
import Foundation
import Testing

@Suite("GtfsInfo")
final class GtfsInfoTests {

    // MARK: - Decoding

    @Test("decodes standard ISO 8601 array response")
    func decodesStandardResponse() throws {
        let json = """
        [
          {
            "BookingId": "25FASU",
            "UpdatedDate": "2025-05-01T12:00:00.000-07:00",
            "EarliestServiceDate": "2025-04-28T00:00:00.000-07:00",
            "LatestServiceDate": "2025-08-31T00:00:00.000-07:00"
          }
        ]
        """
        let results = try decode(json)
        #expect(results.count == 1)
        #expect(results[0].bookingId == GtfsInfo.sample.bookingId)
        #expect(results[0].updatedDate == GtfsInfo.sample.updatedDate)
        #expect(results[0].earliestServiceDate == GtfsInfo.sample.earliestServiceDate)
        #expect(results[0].latestServiceDate == GtfsInfo.sample.latestServiceDate)
    }

    @Test("decodes API response with 7 fractional-second digits")
    func decodesSevenFractionalDigits() throws {
        let json = """
        [
          {
            "BookingId": "26SPSU",
            "UpdatedDate": "2026-05-18T16:48:54.3989122-07:00",
            "EarliestServiceDate": "2026-05-18T16:48:54.3989122-07:00",
            "LatestServiceDate": "2026-05-18T16:48:54.3989122-07:00"
          }
        ]
        """
        let results = try decode(json)
        #expect(results.count == 1)
        #expect(results[0].bookingId == "26SPSU")
        #expect(results[0].updatedDate == results[0].earliestServiceDate)
    }

    @Test("decodes empty array")
    func decodesEmptyArray() throws {
        let results = try decode("[]")
        #expect(results.isEmpty)
    }

    @Test("decodes multiple elements")
    func decodesMultipleElements() throws {
        let json = """
        [
          {
            "BookingId": "25FASU",
            "UpdatedDate": "2025-05-01T12:00:00.000-07:00",
            "EarliestServiceDate": "2025-04-28T00:00:00.000-07:00",
            "LatestServiceDate": "2025-08-31T00:00:00.000-07:00"
          },
          {
            "BookingId": "25WRSU",
            "UpdatedDate": "2025-09-01T12:00:00.000-07:00",
            "EarliestServiceDate": "2025-09-01T00:00:00.000-07:00",
            "LatestServiceDate": "2026-01-15T00:00:00.000-07:00"
          }
        ]
        """
        let results = try decode(json)
        #expect(results.count == 2)
        #expect(results[0].bookingId == "25FASU")
        #expect(results[1].bookingId == "25WRSU")
    }

    @Test("throws on malformed date string")
    func throwsOnMalformedDate() {
        let json = """
        [
          {
            "BookingId": "25FASU",
            "UpdatedDate": "not-a-date",
            "EarliestServiceDate": "2025-04-28T00:00:00.000-07:00",
            "LatestServiceDate": "2025-08-31T00:00:00.000-07:00"
          }
        ]
        """
        #expect(throws: DecodingError.self) {
            try decode(json)
        }
    }

    @Test("throws on missing required key")
    func throwsOnMissingKey() {
        let json = """
        [{ "BookingId": "25FASU" }]
        """
        #expect(throws: DecodingError.self) {
            try decode(json)
        }
    }

    // MARK: - Encoding

    @Test("encodes to PascalCase JSON keys")
    func encodesToPascalCaseKeys() throws {
        let encoded = try JSONEncoder().encode(GtfsInfo.sample)
        let dict = try JSONSerialization.jsonObject(with: encoded) as? [String: Any]
        #expect(dict?["BookingId"] != nil)
        #expect(dict?["UpdatedDate"] != nil)
        #expect(dict?["EarliestServiceDate"] != nil)
        #expect(dict?["LatestServiceDate"] != nil)
    }

    @Test("round-trips encode → decode without data loss")
    func roundTrip() throws {
        let original = GtfsInfo.sample
        let encoded = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(GtfsInfo.self, from: encoded)
        #expect(decoded.bookingId == original.bookingId)
        #expect(decoded.updatedDate == original.updatedDate)
        #expect(decoded.earliestServiceDate == original.earliestServiceDate)
        #expect(decoded.latestServiceDate == original.latestServiceDate)
    }

    // MARK: - Mock Data

    @Test("sample has latestServiceDate after earliestServiceDate")
    func sampleDatesAreOrdered() {
        #expect(GtfsInfo.sample.latestServiceDate > GtfsInfo.sample.earliestServiceDate)
    }

    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = GtfsInfo.make(bookingId: "26SPSU")
        #expect(result.bookingId == "26SPSU")
        #expect(result.updatedDate == GtfsInfo.sample.updatedDate)
        #expect(result.earliestServiceDate == GtfsInfo.sample.earliestServiceDate)
        #expect(result.latestServiceDate == GtfsInfo.sample.latestServiceDate)
    }

    // MARK: - Helpers

    private func decode(_ json: String) throws -> [GtfsInfo] {
        try JSONDecoder().decode([GtfsInfo].self, from: Data(json.utf8))
    }
}

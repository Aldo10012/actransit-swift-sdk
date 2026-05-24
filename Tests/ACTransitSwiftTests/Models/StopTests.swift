@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test Stop")
final class StopTests {
    // MARK: - Decoding

    @Test("decodes without scheduledTime")
    func decodesWithoutScheduledTime() throws {
        let json = """
        {
            "StopId": 55888,
            "Name": "Contra Costa College",
            "Latitude": 37.9710794,
            "Longitude": -122.3398753
        }
        """
        let result = try decode(json)
        #expect(result.stopId == 55888)
        #expect(result.scheduledTime == nil)
        #expect(result.city == nil)
    }

    @Test("decodes with scheduledTime")
    func decodesWithScheduledTime() throws {
        let json = """
        {
            "StopId": 55888,
            "Name": "Contra Costa College",
            "Latitude": 37.9710794,
            "Longitude": -122.3398753,
            "ScheduledTime": "2026-05-23T05:10:00.000-07:00"
        }
        """
        let result = try decode(json)
        #expect(result.stopId == 55888)
        #expect(result.scheduledTime != nil)
    }

    @Test("decodes scheduledTime with 7 fractional-second digits")
    func decodesSevenFractionalDigits() throws {
        let json = """
        {
            "StopId": 55888,
            "Name": "Contra Costa College",
            "Latitude": 37.9710794,
            "Longitude": -122.3398753,
            "ScheduledTime": "2026-05-23T05:10:00.3989122-07:00"
        }
        """
        let result = try decode(json)
        #expect(result.scheduledTime != nil)
    }

    @Test("throws on malformed scheduledTime")
    func throwsOnMalformedScheduledTime() {
        let json = """
        {
            "StopId": 55888,
            "Name": "Contra Costa College",
            "Latitude": 37.9710794,
            "Longitude": -122.3398753,
            "ScheduledTime": "not-a-date"
        }
        """
        #expect(throws: DecodingError.self) {
            try decode(json)
        }
    }

    // MARK: - Encoding

    @Test("encodes to PascalCase JSON keys")
    func encodesToPascalCaseKeys() throws {
        let encoded = try JSONEncoder().encode(Stop.sample)
        let dict = try JSONSerialization.jsonObject(with: encoded) as? [String: Any]
        #expect(dict?["StopId"] != nil)
        #expect(dict?["Name"] != nil)
        #expect(dict?["Latitude"] != nil)
        #expect(dict?["Longitude"] != nil)
        #expect(dict?["ScheduledTime"] != nil)
    }

    @Test("encodes scheduledTime when set")
    func encodesScheduledTimeWhenSet() throws {
        let date = ISO8601DateFormatter.ACTFormat.date(from: "2026-05-23T05:10:00.000-07:00")!
        let stop = Stop.make(scheduledTime: date)
        let encoded = try JSONEncoder().encode(stop)
        let dict = try JSONSerialization.jsonObject(with: encoded) as? [String: Any]
        #expect(dict?["ScheduledTime"] as? String != nil)
    }

    @Test("encodes nil scheduledTime")
    func encodesNilScheduledTime() throws {
        let encoded = try JSONEncoder().encode(Stop.minimal)
        let dict = try JSONSerialization.jsonObject(with: encoded) as? [String: Any]
        #expect(dict?["ScheduledTime"] is NSNull)
    }

    @Test("round-trips encode → decode with scheduledTime")
    func roundTripWithScheduledTime() throws {
        let date = ISO8601DateFormatter.ACTFormat.date(from: "2026-05-23T05:10:00.000-07:00")!
        let original = Stop.make(scheduledTime: date)
        let encoded = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(Stop.self, from: encoded)
        #expect(decoded.stopId == original.stopId)
        #expect(decoded.scheduledTime == original.scheduledTime)
    }

    // MARK: - Mock Data

    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = Stop.make(stopId: 99999)
        #expect(result.stopId == 99999)
        #expect(result.name == Stop.sample.name)
        #expect(result.latitude == Stop.sample.latitude)
        #expect(result.longitude == Stop.sample.longitude)
    }

    // MARK: - Helpers

    private func decode(_ json: String) throws -> Stop {
        try JSONDecoder().decode(Stop.self, from: Data(json.utf8))
    }
}

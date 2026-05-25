@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test TripException")
final class TripExceptionTests {
    // MARK: - Decoding

    @Test("decodes standard ISO 8601 array response")
    func decodesStandardResponse() throws {
        let json = """
        [
          {
            "TripExceptionId": 12345,
            "EventType": "Canceled",
            "IncidentId": "INC-001",
            "IncidentUniqueId": 67890,
            "OpenDateTime": "2025-05-01T08:00:00.000-07:00",
            "IncidentAddDateTime": "2025-05-01T07:55:00.000-07:00",
            "ScheduleType": "Weekday",
            "SourceType": "Incident",
            "TripNumber": 1001,
            "InternalTripNumber": 5001,
            "TripStartTime": "2025-05-01T09:00:00.000-07:00",
            "RouteAlpha": "51A",
            "Direction": "NB",
            "PatternId": 301,
            "BookingId": "2604SP",
            "FromId511": "51096",
            "FromStopId": "1234",
            "ToId511": "53077",
            "ToStopId": "5678",
            "FromStopDescription": "Main St & 1st Ave",
            "FromStopLatitude": 37.8044,
            "FromStopLongitude": -122.2711,
            "ToStopDescription": "Broadway & 5th Ave",
            "ToStopLatitude": 37.8102,
            "ToStopLongitude": -122.2705,
            "StopsInOrder": "1234,2345,3456,5678"
          }
        ]
        """
        let results = try decode(json)
        #expect(results.count == 1)
        #expect(results[0].tripExceptionId == TripException.sample.tripExceptionId)
        #expect(results[0].eventType == TripException.sample.eventType)
        #expect(results[0].incidentId == TripException.sample.incidentId)
        #expect(results[0].incidentUniqueId == TripException.sample.incidentUniqueId)
        #expect(results[0].openDateTime == TripException.sample.openDateTime)
        #expect(results[0].incidentAddDateTime == TripException.sample.incidentAddDateTime)
        #expect(results[0].scheduleType == TripException.sample.scheduleType)
        #expect(results[0].sourceType == TripException.sample.sourceType)
        #expect(results[0].tripNumber == TripException.sample.tripNumber)
        #expect(results[0].internalTripNumber == TripException.sample.internalTripNumber)
        #expect(results[0].tripStartTime == TripException.sample.tripStartTime)
        #expect(results[0].routeAlpha == TripException.sample.routeAlpha)
        #expect(results[0].direction == TripException.sample.direction)
        #expect(results[0].patternId == TripException.sample.patternId)
        #expect(results[0].bookingId == TripException.sample.bookingId)
        #expect(results[0].fromId511 == TripException.sample.fromId511)
        #expect(results[0].fromStopId == TripException.sample.fromStopId)
        #expect(results[0].toId511 == TripException.sample.toId511)
        #expect(results[0].toStopId == TripException.sample.toStopId)
        #expect(results[0].fromStopDescription == TripException.sample.fromStopDescription)
        #expect(results[0].toStopDescription == TripException.sample.toStopDescription)
        #expect(results[0].fromStopLatitude == TripException.sample.fromStopLatitude)
        #expect(results[0].fromStopLongitude == TripException.sample.fromStopLongitude)
        #expect(results[0].toStopLatitude == TripException.sample.toStopLatitude)
        #expect(results[0].toStopLongitude == TripException.sample.toStopLongitude)
        #expect(results[0].stopsInOrder == TripException.sample.stopsInOrder)
    }

    @Test("decodes API response with 7 fractional-second digits")
    func decodesSevenFractionalDigits() throws {
        let json = """
        [
          {
            "TripExceptionId": 99,
            "EventType": "Canceled",
            "IncidentId": "INC-X",
            "IncidentUniqueId": 1,
            "OpenDateTime": "2026-05-18T15:20:54.1878974-07:00",
            "IncidentAddDateTime": "2026-05-18T15:20:54.1878974-07:00",
            "ScheduleType": "Weekday",
            "SourceType": "Incident",
            "TripNumber": 1,
            "InternalTripNumber": 1,
            "TripStartTime": "2026-05-18T15:20:54.1878974-07:00",
            "RouteAlpha": "1",
            "Direction": "SB",
            "PatternId": 1,
            "BookingId": "2604SP",
            "FromId511": "1",
            "FromStopId": "1",
            "ToId511": "2",
            "ToStopId": "2",
            "FromStopDescription": "A",
            "FromStopLatitude": 0.0,
            "FromStopLongitude": 0.0,
            "ToStopDescription": "B",
            "ToStopLatitude": 0.0,
            "ToStopLongitude": 0.0,
            "StopsInOrder": "1,2"
          }
        ]
        """
        let results = try decode(json)
        #expect(results.count == 1)
        #expect(results[0].openDateTime == results[0].incidentAddDateTime)
        #expect(results[0].incidentAddDateTime == results[0].tripStartTime)
    }

    @Test("decodes empty array")
    func decodesEmptyArray() throws {
        let results = try decode("[]")
        #expect(results.isEmpty)
    }

    @Test("throws on malformed date string")
    func throwsOnMalformedDate() {
        let json = """
        [
          {
            "TripExceptionId": 12345,
            "EventType": "Canceled",
            "IncidentId": "INC-001",
            "IncidentUniqueId": 67890,
            "OpenDateTime": "not-a-date",
            "IncidentAddDateTime": "2025-05-01T07:55:00.000-07:00",
            "ScheduleType": "Weekday",
            "SourceType": "Incident",
            "TripNumber": 1001,
            "InternalTripNumber": 5001,
            "TripStartTime": "2025-05-01T09:00:00.000-07:00",
            "RouteAlpha": "51A",
            "Direction": "NB",
            "PatternId": 301,
            "BookingId": "2604SP",
            "FromId511": "51096",
            "FromStopId": "1234",
            "ToId511": "53077",
            "ToStopId": "5678",
            "FromStopDescription": "Main St & 1st Ave",
            "FromStopLatitude": 37.8044,
            "FromStopLongitude": -122.2711,
            "ToStopDescription": "Broadway & 5th Ave",
            "ToStopLatitude": 37.8102,
            "ToStopLongitude": -122.2705,
            "StopsInOrder": "1234,2345,3456,5678"
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
        [{ "TripExceptionId": 12345 }]
        """
        #expect(throws: DecodingError.self) {
            try decode(json)
        }
    }

    // MARK: - Encoding

    @Test("encodes to PascalCase JSON keys")
    func encodesToPascalCaseKeys() throws {
        let encoded = try JSONEncoder().encode(TripException.sample)
        let dict = try JSONSerialization.jsonObject(with: encoded) as? [String: Any]
        #expect(dict?["TripExceptionId"] != nil)
        #expect(dict?["EventType"] != nil)
        #expect(dict?["IncidentId"] != nil)
        #expect(dict?["IncidentUniqueId"] != nil)
        #expect(dict?["OpenDateTime"] != nil)
        #expect(dict?["IncidentAddDateTime"] != nil)
        #expect(dict?["ScheduleType"] != nil)
        #expect(dict?["SourceType"] != nil)
        #expect(dict?["TripNumber"] != nil)
        #expect(dict?["InternalTripNumber"] != nil)
        #expect(dict?["TripStartTime"] != nil)
        #expect(dict?["RouteAlpha"] != nil)
        #expect(dict?["Direction"] != nil)
        #expect(dict?["PatternId"] != nil)
        #expect(dict?["BookingId"] != nil)
        #expect(dict?["FromId511"] != nil)
        #expect(dict?["FromStopId"] != nil)
        #expect(dict?["ToId511"] != nil)
        #expect(dict?["ToStopId"] != nil)
        #expect(dict?["FromStopDescription"] != nil)
        #expect(dict?["ToStopDescription"] != nil)
        #expect(dict?["FromStopLatitude"] != nil)
        #expect(dict?["FromStopLongitude"] != nil)
        #expect(dict?["ToStopLatitude"] != nil)
        #expect(dict?["ToStopLongitude"] != nil)
        #expect(dict?["StopsInOrder"] != nil)
    }

    @Test("round-trips encode → decode without data loss")
    func roundTrip() throws {
        let original = TripException.sample
        let encoded = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(TripException.self, from: encoded)
        #expect(decoded.tripExceptionId == original.tripExceptionId)
        #expect(decoded.eventType == original.eventType)
        #expect(decoded.incidentId == original.incidentId)
        #expect(decoded.incidentUniqueId == original.incidentUniqueId)
        #expect(decoded.openDateTime == original.openDateTime)
        #expect(decoded.incidentAddDateTime == original.incidentAddDateTime)
        #expect(decoded.scheduleType == original.scheduleType)
        #expect(decoded.sourceType == original.sourceType)
        #expect(decoded.tripNumber == original.tripNumber)
        #expect(decoded.internalTripNumber == original.internalTripNumber)
        #expect(decoded.tripStartTime == original.tripStartTime)
        #expect(decoded.routeAlpha == original.routeAlpha)
        #expect(decoded.direction == original.direction)
        #expect(decoded.patternId == original.patternId)
        #expect(decoded.bookingId == original.bookingId)
        #expect(decoded.fromId511 == original.fromId511)
        #expect(decoded.fromStopId == original.fromStopId)
        #expect(decoded.toId511 == original.toId511)
        #expect(decoded.toStopId == original.toStopId)
        #expect(decoded.fromStopDescription == original.fromStopDescription)
        #expect(decoded.toStopDescription == original.toStopDescription)
        #expect(decoded.fromStopLatitude == original.fromStopLatitude)
        #expect(decoded.fromStopLongitude == original.fromStopLongitude)
        #expect(decoded.toStopLatitude == original.toStopLatitude)
        #expect(decoded.toStopLongitude == original.toStopLongitude)
        #expect(decoded.stopsInOrder == original.stopsInOrder)
    }

    // MARK: - Mock Data

    @Test("sample has tripStartTime after incidentAddDateTime")
    func sampleDatesAreOrdered() {
        #expect(TripException.sample.tripStartTime > TripException.sample.incidentAddDateTime)
    }

    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = TripException.make(tripExceptionId: 99999)
        #expect(result.tripExceptionId == 99999)
        #expect(result.eventType == TripException.sample.eventType)
        #expect(result.routeAlpha == TripException.sample.routeAlpha)
        #expect(result.tripStartTime == TripException.sample.tripStartTime)
    }

    // MARK: - Helpers

    private func decode(_ json: String) throws -> [TripException] {
        try JSONDecoder().decode([TripException].self, from: Data(json.utf8))
    }
}

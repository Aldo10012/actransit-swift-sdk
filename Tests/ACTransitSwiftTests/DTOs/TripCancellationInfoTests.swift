@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test TripCancellationInfo")
final class TripCancellationInfoTests {
    // MARK: - Decoding

    @Test("decodes standard ISO 8601 response")
    func decodesStandardResponse() throws {
        let json = """
        {
          "RouteAlpha": "51A",
          "Direction": "NB",
          "BookingId": "25FASU",
          "Canceled": true,
          "Reinstated": false,
          "TripNumber": 1001,
          "InternalTripNumber": 5001,
          "TripStartTime": "2025-05-01T09:00:00.000-07:00",
          "ScheduleType": "Weekday",
          "NextTripNumber": 1002,
          "NextInternalTripNumber": 5002,
          "NextTripStartTime": "2025-05-01T09:30:00.000-07:00",
          "NextScheduleType": "Weekday",
          "PrevTripNumber": 1000,
          "PrevInternalTripNumber": 5000,
          "PrevTripStartTime": "2025-05-01T08:30:00.000-07:00",
          "PrevScheduleType": "Weekday"
        }
        """
        let result = try decode(json)
        #expect(result.routeAlpha == TripCancellationInfo.sample.routeAlpha)
        #expect(result.direction == TripCancellationInfo.sample.direction)
        #expect(result.bookingId == TripCancellationInfo.sample.bookingId)
        #expect(result.canceled == TripCancellationInfo.sample.canceled)
        #expect(result.reinstated == TripCancellationInfo.sample.reinstated)
        #expect(result.tripNumber == TripCancellationInfo.sample.tripNumber)
        #expect(result.internalTripNumber == TripCancellationInfo.sample.internalTripNumber)
        #expect(result.tripStartTime == TripCancellationInfo.sample.tripStartTime)
        #expect(result.scheduleType == TripCancellationInfo.sample.scheduleType)
        #expect(result.nextTripNumber == TripCancellationInfo.sample.nextTripNumber)
        #expect(result.nextInternalTripNumber == TripCancellationInfo.sample.nextInternalTripNumber)
        #expect(result.nextTripStartTime == TripCancellationInfo.sample.nextTripStartTime)
        #expect(result.nextScheduleType == TripCancellationInfo.sample.nextScheduleType)
        #expect(result.prevTripNumber == TripCancellationInfo.sample.prevTripNumber)
        #expect(result.prevInternalTripNumber == TripCancellationInfo.sample.prevInternalTripNumber)
        #expect(result.prevTripStartTime == TripCancellationInfo.sample.prevTripStartTime)
        #expect(result.prevScheduleType == TripCancellationInfo.sample.prevScheduleType)
    }

    @Test("decodes API response with 7 fractional-second digits")
    func decodesSevenFractionalDigits() throws {
        let json = """
        {
          "RouteAlpha": "1",
          "Direction": "SB",
          "BookingId": "25FASU",
          "Canceled": false,
          "Reinstated": false,
          "TripNumber": 1,
          "InternalTripNumber": 1,
          "TripStartTime": "2026-05-20T01:16:50.4420546-07:00",
          "ScheduleType": "Weekday",
          "NextTripNumber": 2,
          "NextInternalTripNumber": 2,
          "NextTripStartTime": "2026-05-20T01:16:50.4420546-07:00",
          "NextScheduleType": "Weekday",
          "PrevTripNumber": 0,
          "PrevInternalTripNumber": 0,
          "PrevTripStartTime": "2026-05-20T01:16:50.4420546-07:00",
          "PrevScheduleType": "Weekday"
        }
        """
        let result = try decode(json)
        #expect(result.tripStartTime == result.nextTripStartTime)
        #expect(result.nextTripStartTime == result.prevTripStartTime)
    }

    @Test("throws on malformed date string")
    func throwsOnMalformedDate() {
        let json = """
        {
          "RouteAlpha": "51A",
          "Direction": "NB",
          "BookingId": "25FASU",
          "Canceled": true,
          "Reinstated": false,
          "TripNumber": 1001,
          "InternalTripNumber": 5001,
          "TripStartTime": "not-a-date",
          "ScheduleType": "Weekday",
          "NextTripNumber": 1002,
          "NextInternalTripNumber": 5002,
          "NextTripStartTime": "2025-05-01T09:30:00.000-07:00",
          "NextScheduleType": "Weekday",
          "PrevTripNumber": 1000,
          "PrevInternalTripNumber": 5000,
          "PrevTripStartTime": "2025-05-01T08:30:00.000-07:00",
          "PrevScheduleType": "Weekday"
        }
        """
        #expect(throws: DecodingError.self) {
            try decode(json)
        }
    }

    @Test("throws on missing required key")
    func throwsOnMissingKey() {
        let json = """
        { "RouteAlpha": "51A" }
        """
        #expect(throws: DecodingError.self) {
            try decode(json)
        }
    }

    // MARK: - Encoding

    @Test("encodes to PascalCase JSON keys")
    func encodesToPascalCaseKeys() throws {
        let encoded = try JSONEncoder().encode(TripCancellationInfo.sample)
        let dict = try JSONSerialization.jsonObject(with: encoded) as? [String: Any]
        #expect(dict?["RouteAlpha"] != nil)
        #expect(dict?["Direction"] != nil)
        #expect(dict?["BookingId"] != nil)
        #expect(dict?["Canceled"] != nil)
        #expect(dict?["Reinstated"] != nil)
        #expect(dict?["TripNumber"] != nil)
        #expect(dict?["InternalTripNumber"] != nil)
        #expect(dict?["TripStartTime"] != nil)
        #expect(dict?["ScheduleType"] != nil)
        #expect(dict?["NextTripNumber"] != nil)
        #expect(dict?["NextInternalTripNumber"] != nil)
        #expect(dict?["NextTripStartTime"] != nil)
        #expect(dict?["NextScheduleType"] != nil)
        #expect(dict?["PrevTripNumber"] != nil)
        #expect(dict?["PrevInternalTripNumber"] != nil)
        #expect(dict?["PrevTripStartTime"] != nil)
        #expect(dict?["PrevScheduleType"] != nil)
    }

    @Test("round-trips encode → decode without data loss")
    func roundTrip() throws {
        let original = TripCancellationInfo.sample
        let encoded = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(TripCancellationInfo.self, from: encoded)
        #expect(decoded.routeAlpha == original.routeAlpha)
        #expect(decoded.direction == original.direction)
        #expect(decoded.bookingId == original.bookingId)
        #expect(decoded.canceled == original.canceled)
        #expect(decoded.reinstated == original.reinstated)
        #expect(decoded.tripNumber == original.tripNumber)
        #expect(decoded.internalTripNumber == original.internalTripNumber)
        #expect(decoded.tripStartTime == original.tripStartTime)
        #expect(decoded.scheduleType == original.scheduleType)
        #expect(decoded.nextTripNumber == original.nextTripNumber)
        #expect(decoded.nextInternalTripNumber == original.nextInternalTripNumber)
        #expect(decoded.nextTripStartTime == original.nextTripStartTime)
        #expect(decoded.nextScheduleType == original.nextScheduleType)
        #expect(decoded.prevTripNumber == original.prevTripNumber)
        #expect(decoded.prevInternalTripNumber == original.prevInternalTripNumber)
        #expect(decoded.prevTripStartTime == original.prevTripStartTime)
        #expect(decoded.prevScheduleType == original.prevScheduleType)
    }

    // MARK: - Mock Data

    @Test("sample has nextTripStartTime after tripStartTime and prevTripStartTime before tripStartTime")
    func sampleDatesAreOrdered() {
        #expect(TripCancellationInfo.sample.nextTripStartTime > TripCancellationInfo.sample.tripStartTime)
        #expect(TripCancellationInfo.sample.prevTripStartTime < TripCancellationInfo.sample.tripStartTime)
    }

    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = TripCancellationInfo.make(tripNumber: 9999)
        #expect(result.tripNumber == 9999)
        #expect(result.routeAlpha == TripCancellationInfo.sample.routeAlpha)
        #expect(result.direction == TripCancellationInfo.sample.direction)
        #expect(result.tripStartTime == TripCancellationInfo.sample.tripStartTime)
    }

    // MARK: - Helpers

    private func decode(_ json: String) throws -> TripCancellationInfo {
        try JSONDecoder().decode(TripCancellationInfo.self, from: Data(json.utf8))
    }
}

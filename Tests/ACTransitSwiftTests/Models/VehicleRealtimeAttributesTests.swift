@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test VehicleRealtimeAttributes")
final class VehicleRealtimeAttributesTests {
    // MARK: - Decoding

    @Test("decodes standard ISO 8601 response")
    func decodesStandardResponse() throws {
        let json = """
        {
            "VehicleId": "1505",
            "CurrentRoute": "51A",
            "LastPositionLatitude": 37.8376083374023,
            "LastPositionLongitude": -122.281852722168,
            "DateTimePositionReported": "2026-05-23T21:17:35.000-07:00",
            "VehicleCapacity": 60,
            "CurrentPassengerCount": 25,
            "EstimatedOccupancyPercentage": 42,
            "EstimatedOccupancyStatusColor": "#00CC00",
            "EstimatedOccupancyStatus": "Not Crowded",
            "DateTimeAPCReported": "2026-05-23T21:17:35.000-07:00"
        }
        """
        let result = try decode(json)
        #expect(result.vehicleId == VehicleRealtimeAttributes.sample.vehicleId)
        #expect(result.currentRoute == VehicleRealtimeAttributes.sample.currentRoute)
        #expect(result.dateTimePositionReported == VehicleRealtimeAttributes.sample.dateTimePositionReported)
        #expect(result.dateTimeAPCReported == VehicleRealtimeAttributes.sample.dateTimeAPCReported)
        #expect(result.estimatedOccupancyStatus == VehicleRealtimeAttributes.sample.estimatedOccupancyStatus)
    }

    @Test("decodes with 7 fractional-second digits")
    func decodesSevenFractionalDigits() throws {
        let json = """
        {
            "VehicleId": "1505",
            "CurrentRoute": "51A",
            "DateTimePositionReported": "2026-05-23T19:16:35.9160491-07:00",
            "DateTimeAPCReported": "2026-05-23T19:16:35.9160491-07:00"
        }
        """
        let result = try decode(json)
        #expect(result.dateTimePositionReported != nil)
        #expect(result.dateTimeAPCReported != nil)
        #expect(result.dateTimePositionReported == result.dateTimeAPCReported)
    }

    @Test("decodes with all nullable fields absent")
    func decodesWithNullableFieldsAbsent() throws {
        let json = """
        {
            "VehicleId": "1505",
            "CurrentRoute": "51A"
        }
        """
        let result = try decode(json)
        #expect(result.vehicleId == "1505")
        #expect(result.lastPositionLatitude == nil)
        #expect(result.lastPositionLongitude == nil)
        #expect(result.dateTimePositionReported == nil)
        #expect(result.vehicleCapacity == nil)
        #expect(result.currentPassengerCount == nil)
        #expect(result.estimatedOccupancyPercentage == nil)
        #expect(result.estimatedOccupancyStatusColor == nil)
        #expect(result.estimatedOccupancyStatus == nil)
        #expect(result.dateTimeAPCReported == nil)
    }

    @Test("throws on malformed date string")
    func throwsOnMalformedDate() {
        let json = """
        {
            "VehicleId": "1505",
            "CurrentRoute": "51A",
            "DateTimePositionReported": "not-a-date"
        }
        """
        #expect(throws: DecodingError.self) {
            try decode(json)
        }
    }

    // MARK: - Encoding

    @Test("encodes to PascalCase JSON keys")
    func encodesToPascalCaseKeys() throws {
        let encoded = try JSONEncoder().encode(VehicleRealtimeAttributes.sample)
        let dict = try JSONSerialization.jsonObject(with: encoded) as? [String: Any]
        #expect(dict?["VehicleId"] != nil)
        #expect(dict?["CurrentRoute"] != nil)
        #expect(dict?["DateTimePositionReported"] != nil)
        #expect(dict?["DateTimeAPCReported"] != nil)
    }

    @Test("round-trips encode → decode without losing dates")
    func roundTrip() throws {
        let original = VehicleRealtimeAttributes.sample
        let encoded = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(VehicleRealtimeAttributes.self, from: encoded)
        #expect(decoded.vehicleId == original.vehicleId)
        #expect(decoded.dateTimePositionReported == original.dateTimePositionReported)
        #expect(decoded.dateTimeAPCReported == original.dateTimeAPCReported)
    }

    // MARK: - Mock Data

    @Test("sample has non-nil dates")
    func sampleHasNonNilDates() {
        #expect(VehicleRealtimeAttributes.sample.dateTimePositionReported != nil)
        #expect(VehicleRealtimeAttributes.sample.dateTimeAPCReported != nil)
    }

    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = VehicleRealtimeAttributes.make(vehicleId: "9999")
        #expect(result.vehicleId == "9999")
        #expect(result.currentRoute == VehicleRealtimeAttributes.sample.currentRoute)
        #expect(result.vehicleCapacity == VehicleRealtimeAttributes.sample.vehicleCapacity)
    }

    // MARK: - Helpers

    private func decode(_ json: String) throws -> VehicleRealtimeAttributes {
        try JSONDecoder().decode(VehicleRealtimeAttributes.self, from: Data(json.utf8))
    }
}

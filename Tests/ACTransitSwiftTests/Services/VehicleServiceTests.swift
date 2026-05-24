@testable import ACTransitSwift
import EZNetworking
import Foundation
import Testing

@Suite("Test VehicleService")
final class VehicleServiceTests {
    private var sut: VehicleService

    init() {
        sut = VehicleService(token: "mockToken", performer: MockRequestPerformer())
    }

    private func setup(mockJSON: Data?) {
        var performer = MockRequestPerformer()
        performer.fixture = mockJSON
        sut = VehicleService(token: "mockToken", performer: performer)
    }

    // MARK: - Tests

    @Test("test .bulkRealtimeAttributes(vehicles:) success case")
    func bulkRealtimeAttributes() async throws {
        let jsonString = """
        [
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
        ]
        """
        setup(mockJSON: jsonString.data(using: .utf8))

        let result = try await sut.bulkRealtimeAttributes(vehicles: ["1505"])
        #expect(result.count == 1)
        #expect(result[0].vehicleId == VehicleRealtimeAttributes.sample.vehicleId)
        #expect(result[0].currentRoute == VehicleRealtimeAttributes.sample.currentRoute)
    }

    @Test("test .routeRealtimeAttributes(routeName:) success case")
    func routeRealtimeAttributes() async throws {
        let jsonString = """
        [
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
        ]
        """
        setup(mockJSON: jsonString.data(using: .utf8))

        let result = try await sut.routeRealtimeAttributes(routeName: "51A")
        #expect(result.count == 1)
        #expect(result[0].vehicleId == VehicleRealtimeAttributes.sample.vehicleId)
        #expect(result[0].currentRoute == VehicleRealtimeAttributes.sample.currentRoute)
    }

    @Test("test .vehicleRealtimeAttributes(vehicleId:) success case")
    func vehicleRealtimeAttributes() async throws {
        let jsonString = """
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
        setup(mockJSON: jsonString.data(using: .utf8))

        let result = try await sut.vehicleRealtimeAttributes(vehicleId: "1505")
        #expect(result.vehicleId == VehicleRealtimeAttributes.sample.vehicleId)
        #expect(result.currentRoute == VehicleRealtimeAttributes.sample.currentRoute)
        #expect(result.vehicleCapacity == VehicleRealtimeAttributes.sample.vehicleCapacity)
    }

    @Test("test .realtimeAttributes() success case")
    func realtimeAttributes() async throws {
        let jsonString = """
        [
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
        ]
        """
        setup(mockJSON: jsonString.data(using: .utf8))

        let result = try await sut.realtimeAttributes()
        #expect(result.count == 1)
        #expect(result[0].vehicleId == VehicleRealtimeAttributes.sample.vehicleId)
        #expect(result[0].currentRoute == VehicleRealtimeAttributes.sample.currentRoute)
        #expect(result[0].estimatedOccupancyStatus == VehicleRealtimeAttributes.sample.estimatedOccupancyStatus)
        #expect(result[0].vehicleCapacity == VehicleRealtimeAttributes.sample.vehicleCapacity)
    }

    @Test("test .vehicleCharacteristics(vehicleId:) success case")
    func vehicleCharacteristics() async throws {
        let jsonString = """
        {
            "VehicleId": "1505",
            "IsActive": true,
            "Description": "Gillig - Diesel",
            "VehicleType": "40",
            "VehicleTypeDescription": "Standard Bus",
            "Make": "Gillig",
            "SerialNumber": "12345",
            "LicenseNumber": "1234567",
            "Length": "40",
            "PropulsionType": "Diesel",
            "HasWiFi": true,
            "HasAC": true,
            "StandingCapacity": "30",
            "SeatingCapacity": "38",
            "LimitCapacity": "60"
        }
        """
        setup(mockJSON: jsonString.data(using: .utf8))

        let result = try await sut.vehicleCharacteristics(vehicleId: "1505")
        #expect(result.vehicleId == VehicleCharacteristics.sample.vehicleId)
        #expect(result.manufacturer == VehicleCharacteristics.sample.manufacturer)
        #expect(result.propulsionType == VehicleCharacteristics.sample.propulsionType)
    }

    @Test("test .characteristics() success case")
    func characteristics() async throws {
        let jsonString = """
        [
            {
                "VehicleId": "1505",
                "IsActive": true,
                "Description": "Gillig - Diesel",
                "VehicleType": "40",
                "VehicleTypeDescription": "Standard Bus",
                "Make": "Gillig",
                "SerialNumber": "12345",
                "LicenseNumber": "1234567",
                "Length": "40",
                "PropulsionType": "Diesel",
                "HasWiFi": true,
                "HasAC": true,
                "StandingCapacity": "30",
                "SeatingCapacity": "38",
                "LimitCapacity": "60"
            }
        ]
        """
        setup(mockJSON: jsonString.data(using: .utf8))

        let result = try await sut.characteristics()
        #expect(result.count == 1)
        #expect(result[0].vehicleId == VehicleCharacteristics.sample.vehicleId)
        #expect(result[0].isActive == VehicleCharacteristics.sample.isActive)
        #expect(result[0].description == VehicleCharacteristics.sample.description)
        #expect(result[0].manufacturer == VehicleCharacteristics.sample.manufacturer)
        #expect(result[0].propulsionType == VehicleCharacteristics.sample.propulsionType)
        #expect(result[0].hasWiFi == VehicleCharacteristics.sample.hasWiFi)
        #expect(result[0].hasAC == VehicleCharacteristics.sample.hasAC)
        #expect(result[0].limitCapacity == VehicleCharacteristics.sample.limitCapacity)
    }

    @Test("test .vehicle(vehicleId:) success case")
    func vehicle() async throws {
        let jsonString = """
        {
            "VehicleId": 1505,
            "CurrentTripId": 11862132,
            "Latitude": 37.8376083374023,
            "Longitude": -122.281852722168,
            "Heading": 350,
            "TimeLastReported": "2026-05-23T21:17:35"
        }
        """
        setup(mockJSON: jsonString.data(using: .utf8))

        let result = try await sut.vehicle(vehicleId: 1505)
        #expect(result.vehicleId == Vehicle.sample.vehicleId)
        #expect(result.currentTripId == Vehicle.sample.currentTripId)
        #expect(result.latitude == Vehicle.sample.latitude)
        #expect(result.longitude == Vehicle.sample.longitude)
        #expect(result.heading == Vehicle.sample.heading)
        #expect(result.timeLastReported == Vehicle.sample.timeLastReported)
    }
}

// MARK: - mocks

private struct MockRequestPerformer: RequestPerformable {
    var fixture: Data?

    func perform<T: Decodable & Sendable>(request: Request, decodeTo decodableObject: T.Type) async throws -> T {
        guard let fixture else {
            throw NSError(domain: "no fixture", code: -1)
        }
        return try JSONDecoder().decode(decodableObject, from: fixture)
    }
}

import EZNetworking
import Foundation

public struct VehicleService {
    private let token: String
    private let performer: RequestPerformable

    init(token: String, performer: RequestPerformable) {
        self.token = token
        self.performer = performer
    }

    /// Returns real-time location and status for a single vehicle.
    /// - Parameters:
    ///   - vehicleId: Vehicle identifier.
    public func vehicle(vehicleId: Int) async throws -> Vehicle {
        try await performer.perform(
            request: VehicleEndpoint.vehicle(vehicleId: vehicleId).getRequest(token: token),
            decodeTo: Vehicle.self
        )
    }

    /// Returns physical and operational specifications for one or all active vehicles.
    /// - Parameters:
    ///   - vehicleId: Alphanumeric string representing the vehicle ID (ie. bus number); omit to retrieve all active vehicles.
    public func characteristics(vehicleId: String? = nil) async throws -> [VehicleCharacteristics] {
        try await performer.perform(
            request: VehicleEndpoint.characteristics(vehicleId: vehicleId).getRequest(token: token),
            decodeTo: [VehicleCharacteristics].self
        )
    }
}

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
}

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

    /// Returns physical and operational specifications for a specific vehicle.
    /// - Parameters:
    ///   - vehicleId: Vehicle (bus) number.
    public func vehicleCharacteristics(vehicleId: String) async throws -> VehicleCharacteristics {
        try await performer.perform(
            request: VehicleEndpoint.vehicleCharacteristics(vehicleId: vehicleId).getRequest(token: token),
            decodeTo: VehicleCharacteristics.self
        )
    }

    /// Returns real-time position and passenger occupancy data for one or more vehicles.
    /// - Parameters:
    ///   - vehicleId: Vehicle (bus) number filter.
    ///   - routeName: Route name filter.
    public func realtimeAttributes(vehicleId: String? = nil, routeName: String? = nil) async throws -> [VehicleRealtimeAttributes] {
        try await performer.perform(
            request: VehicleEndpoint.realtimeAttributes(vehicleId: vehicleId, routeName: routeName).getRequest(token: token),
            decodeTo: [VehicleRealtimeAttributes].self
        )
    }

    /// Returns real-time attributes for a specific vehicle, optionally filtered by route.
    /// - Parameters:
    ///   - vehicleId: Vehicle (bus) number.
    ///   - routeName: Name of the route that the vehicle is currently servicing.
    public func vehicleRealtimeAttributes(vehicleId: String, routeName: String? = nil) async throws -> VehicleRealtimeAttributes {
        try await performer.perform(
            request: VehicleEndpoint.vehicleRealtimeAttributes(vehicleId: vehicleId, routeName: routeName).getRequest(token: token),
            decodeTo: VehicleRealtimeAttributes.self
        )
    }

    /// Returns real-time attributes for vehicles on a specific route, optionally filtered by vehicle ID.
    /// - Parameters:
    ///   - routeName: Route name identifier.
    ///   - vehicleId: Optional vehicle ID filter.
    public func routeRealtimeAttributes(routeName: String, vehicleId: String? = nil) async throws -> [VehicleRealtimeAttributes] {
        try await performer.perform(
            request: VehicleEndpoint.routeRealtimeAttributes(routeName: routeName, vehicleId: vehicleId).getRequest(token: token),
            decodeTo: [VehicleRealtimeAttributes].self
        )
    }

    /// Returns real-time attributes for multiple vehicles specified in the request body.
    /// - Parameters:
    ///   - vehicles: Collection of vehicle IDs (bus numbers).
    ///   - route: Route name (e.g., `72`).
    public func bulkRealtimeAttributes(vehicles: [String], route: String? = nil) async throws -> [VehicleRealtimeAttributes] {
        try await performer.perform(
            request: VehicleEndpoint.bulkRealtimeAttributes(vehicles: vehicles, route: route).getRequest(token: token),
            decodeTo: [VehicleRealtimeAttributes].self
        )
    }
}

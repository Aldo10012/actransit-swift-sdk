import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=VehicleRequestResponse
public struct VehicleRequestResponse: Codable, Sendable {
    /// Vehicles matching the request.
    public let vehicle: [BusTimeVehicle]
    /// Errors from request processing.
    public let error: [BusTimeError]?

    public init(vehicle: [BusTimeVehicle], error: [BusTimeError]? = nil) {
        self.vehicle = vehicle
        self.error = error
    }
}

/// https://api.actransit.org/transit/Help/Api/GET-actrealtime-vehicle_vid_rt_tmres_callback_lat_lng_searchRadius
public typealias RequestResponseOfVehicleRequestResponse = BusTimeResponse<VehicleRequestResponse>

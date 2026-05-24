import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=Vehicle
public struct Vehicle: Codable, Sendable {
    /// Unique identifier for the vehicle.
    public let vehicleId: Int
    /// The Trip Id that the vehicle is currently servicing.
    public let currentTripId: Int
    /// Geographic coordinate representing the latitude in decimal format. Null if not available.
    public let latitude: Double?
    /// Geographic coordinate representing the longitude in decimal format. Null if not available.
    public let longitude: Double?
    /// Direction of vehicle travel; may be unavailable.
    public let heading: Int?
    /// Last time that information for this vehicle was reported. Null if not available.
    public let timeLastReported: String?

    public init(vehicleId: Int, currentTripId: Int, latitude: Double?, longitude: Double?, heading: Int?, timeLastReported: String?) {
        self.vehicleId = vehicleId
        self.currentTripId = currentTripId
        self.latitude = latitude
        self.longitude = longitude
        self.heading = heading
        self.timeLastReported = timeLastReported
    }

    enum CodingKeys: String, CodingKey {
        case vehicleId = "VehicleId"
        case currentTripId = "CurrentTripId"
        case latitude = "Latitude"
        case longitude = "Longitude"
        case heading = "Heading"
        case timeLastReported = "TimeLastReported"
    }

    // MARK: - Mock Data

    public static let sample = Vehicle(
        vehicleId: 1505,
        currentTripId: 11_862_132,
        latitude: 37.8376083374023,
        longitude: -122.281852722168,
        heading: 350,
        timeLastReported: "2026-05-23T21:17:35"
    )

    public static let minimal = Vehicle(
        vehicleId: 1505,
        currentTripId: 11_862_132,
        latitude: nil,
        longitude: nil,
        heading: nil,
        timeLastReported: nil
    )

    public static func make(
        vehicleId: Int = sample.vehicleId,
        currentTripId: Int = sample.currentTripId,
        latitude: Double? = sample.latitude,
        longitude: Double? = sample.longitude,
        heading: Int? = sample.heading,
        timeLastReported: String? = sample.timeLastReported
    ) -> Vehicle {
        Vehicle(vehicleId: vehicleId, currentTripId: currentTripId, latitude: latitude, longitude: longitude, heading: heading, timeLastReported: timeLastReported)
    }
}

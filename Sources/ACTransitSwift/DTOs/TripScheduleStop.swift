import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=TripScheduleStop
public struct TripScheduleStop: Codable, Sendable {
    /// Unique identifier (ID511) for this stop.
    public let stopId: String
    /// Populated when the stop corresponds to a recognized location.
    public let placeName: String
    /// Unique alphanumeric code that identifies the current well known location.
    public let placeId: String
    /// Brief description of the current stop (normally a location) in natural language.
    public let stopDescription: String
    /// Geographic coordinate expressed in a decimal value.
    public let longitude: Double
    /// Geographic coordinate expressed in a decimal value.
    public let latitude: Double
    /// City or jurisdiction that own this stop.
    public let city: String

    public init(stopId: String, placeName: String, placeId: String, stopDescription: String, longitude: Double, latitude: Double, city: String) {
        self.stopId = stopId
        self.placeName = placeName
        self.placeId = placeId
        self.stopDescription = stopDescription
        self.longitude = longitude
        self.latitude = latitude
        self.city = city
    }

    enum CodingKeys: String, CodingKey {
        case stopId = "StopId"
        case placeName = "PlaceName"
        case placeId = "PlaceId"
        case stopDescription = "StopDescription"
        case longitude = "Longitude"
        case latitude = "Latitude"
        case city = "City"
    }

    // MARK: - Mock Data

    public static let sample = TripScheduleStop(
        stopId: "55867",
        placeName: "San Pablo Ave. & Marin Ave.",
        placeId: "SPMA",
        stopDescription: "San Pablo Av & Marin Av (Albany City Hall)",
        longitude: -122.2976044,
        latitude: 37.886486,
        city: "Albany"
    )

    public static func make(
        stopId: String = sample.stopId,
        placeName: String = sample.placeName,
        placeId: String = sample.placeId,
        stopDescription: String = sample.stopDescription,
        longitude: Double = sample.longitude,
        latitude: Double = sample.latitude,
        city: String = sample.city
    ) -> TripScheduleStop {
        TripScheduleStop(stopId: stopId, placeName: placeName, placeId: placeId, stopDescription: stopDescription, longitude: longitude, latitude: latitude, city: city)
    }
}

import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=StopProfile
public struct StopProfile: Codable, Sendable {
    public let stopId: Int
    public let street: String?
    public let city: String?
    public let siteDirection: String?
    public let site: String?
    public let corner: String?
    public let isInService: Bool
    public let latitude: Double
    public let longitude: Double
    /// Comma-delimited list of route identifiers serving this stop. Split on `","` to obtain individual route IDs.
    public let routes: String?
    public let allowAlighting: Bool
    public let allowBoarding: Bool
    public let placeId: String?
    public let placeDescription: String?
    public let stopServiceAlerts: InfoUrl?
    public let amenities: InfoUrl?
    public let predictions: InfoUrl?
    public let map: InfoUrl?
    public let schedules: [RouteUrl]

    public init(
        stopId: Int,
        street: String?,
        city: String?,
        siteDirection: String?,
        site: String?,
        corner: String?,
        isInService: Bool,
        latitude: Double,
        longitude: Double,
        routes: String?,
        allowAlighting: Bool,
        allowBoarding: Bool,
        placeId: String?,
        placeDescription: String?,
        stopServiceAlerts: InfoUrl?,
        amenities: InfoUrl?,
        predictions: InfoUrl?,
        map: InfoUrl?,
        schedules: [RouteUrl]
    ) {
        self.stopId = stopId
        self.street = street
        self.city = city
        self.siteDirection = siteDirection
        self.site = site
        self.corner = corner
        self.isInService = isInService
        self.latitude = latitude
        self.longitude = longitude
        self.routes = routes
        self.allowAlighting = allowAlighting
        self.allowBoarding = allowBoarding
        self.placeId = placeId
        self.placeDescription = placeDescription
        self.stopServiceAlerts = stopServiceAlerts
        self.amenities = amenities
        self.predictions = predictions
        self.map = map
        self.schedules = schedules
    }

    enum CodingKeys: String, CodingKey {
        case stopId = "StopId"
        case street = "Street"
        case city = "City"
        case siteDirection = "SiteDirection"
        case site = "Site"
        case corner = "Corner"
        case isInService = "IsInService"
        case latitude = "Latitude"
        case longitude = "Longitude"
        case routes = "Routes"
        case allowAlighting = "AllowAlighting"
        case allowBoarding = "AllowBoarding"
        case placeId = "PlaceId"
        case placeDescription = "PlaceDescription"
        case stopServiceAlerts = "StopServiceAlerts"
        case amenities = "Amenities"
        case predictions = "Predictions"
        case map = "Map"
        case schedules = "Schedules"
    }

    // MARK: - Mock Data

    public static let sample = StopProfile(
        stopId: 55888,
        street: "Giant Rd",
        city: "Richmond",
        siteDirection: "NW corner",
        site: "Giant Rd at Castro St",
        corner: "NW",
        isInService: true,
        latitude: 37.9710794,
        longitude: -122.3398753,
        routes: "72,72R",
        allowAlighting: true,
        allowBoarding: true,
        placeId: "CCCO",
        placeDescription: "Contra Costa College",
        stopServiceAlerts: InfoUrl(url: "https://511.org/transit/alerts/55888"),
        amenities: InfoUrl(url: "https://511.org/transit/amenities/55888"),
        predictions: InfoUrl(url: "https://511.org/transit/real-time-arrivals?stopId=55888"),
        map: InfoUrl(url: "https://511.org/transit/stops/map/55888"),
        schedules: [RouteUrl(routeId: "72", url: "https://511.org/transit/schedules/72")]
    )

    public static let minimal = StopProfile(
        stopId: 55888,
        street: nil,
        city: nil,
        siteDirection: nil,
        site: nil,
        corner: nil,
        isInService: true,
        latitude: 37.9710794,
        longitude: -122.3398753,
        routes: nil,
        allowAlighting: true,
        allowBoarding: true,
        placeId: nil,
        placeDescription: nil,
        stopServiceAlerts: nil,
        amenities: nil,
        predictions: nil,
        map: nil,
        schedules: []
    )

    public static func make(
        stopId: Int = sample.stopId,
        street: String? = sample.street,
        city: String? = sample.city,
        siteDirection: String? = sample.siteDirection,
        site: String? = sample.site,
        corner: String? = sample.corner,
        isInService: Bool = sample.isInService,
        latitude: Double = sample.latitude,
        longitude: Double = sample.longitude,
        routes: String? = sample.routes,
        allowAlighting: Bool = sample.allowAlighting,
        allowBoarding: Bool = sample.allowBoarding,
        placeId: String? = sample.placeId,
        placeDescription: String? = sample.placeDescription,
        stopServiceAlerts: InfoUrl? = sample.stopServiceAlerts,
        amenities: InfoUrl? = sample.amenities,
        predictions: InfoUrl? = sample.predictions,
        map: InfoUrl? = sample.map,
        schedules: [RouteUrl] = sample.schedules
    ) -> StopProfile {
        StopProfile(
            stopId: stopId,
            street: street,
            city: city,
            siteDirection: siteDirection,
            site: site,
            corner: corner,
            isInService: isInService,
            latitude: latitude,
            longitude: longitude,
            routes: routes,
            allowAlighting: allowAlighting,
            allowBoarding: allowBoarding,
            placeId: placeId,
            placeDescription: placeDescription,
            stopServiceAlerts: stopServiceAlerts,
            amenities: amenities,
            predictions: predictions,
            map: map,
            schedules: schedules
        )
    }
}

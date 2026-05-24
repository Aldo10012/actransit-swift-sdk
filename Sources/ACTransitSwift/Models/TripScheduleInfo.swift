import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=RouteProfile
public struct RouteProfile: Codable, Sendable {
    /// Name of the route.
    public let routeId: String
    /// Route description.
    public let profile: String

    public init(routeId: String, profile: String) {
        self.routeId = routeId
        self.profile = profile
    }

    enum CodingKeys: String, CodingKey {
        case routeId = "RouteId"
        case profile = "Profile"
    }

    // MARK: - Mock Data

    public static let sample = RouteProfile(
        routeId: "72",
        profile: "Contra Costa College to Jack London Square via San Pablo Ave., El Cerrito del Norte BART, and Downtown Oakland."
    )

    public static func make(
        routeId: String = sample.routeId,
        profile: String = sample.profile
    ) -> RouteProfile {
        RouteProfile(routeId: routeId, profile: profile)
    }
}

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=ServiceException
public struct ServiceException: Codable, Sendable {
    /// Unique identier that represents this service exception.
    public let exceptionCode: String
    /// Pattern unique identifer for the current service exception.
    public let patternId: String
    /// Trip unique identifier for the current service exception.
    public let tripId: [String]
    /// String that represents the days that this route is normally serviced.
    public let operatingDays: String
    /// Collection of dates when this route will not be serviced.
    public let exceptionDates: [String]
    /// Collection of strings that contain, in natural language, service exceptions for a trip.
    public let exceptionNotices: [String]

    public init(exceptionCode: String, patternId: String, tripId: [String], operatingDays: String, exceptionDates: [String], exceptionNotices: [String]) {
        self.exceptionCode = exceptionCode
        self.patternId = patternId
        self.tripId = tripId
        self.operatingDays = operatingDays
        self.exceptionDates = exceptionDates
        self.exceptionNotices = exceptionNotices
    }

    enum CodingKeys: String, CodingKey {
        case exceptionCode = "ExceptionCode"
        case patternId = "PatternId"
        case tripId = "TripId"
        case operatingDays = "OperatingDays"
        case exceptionDates = "ExceptionDates"
        case exceptionNotices = "ExceptionNotices"
    }

    // MARK: - Mock Data

    public static let sample = ServiceException(
        exceptionCode: "EX001",
        patternId: "147",
        tripId: ["2305020"],
        operatingDays: "Mondays through Fridays except holidays",
        exceptionDates: ["2026-05-26"],
        exceptionNotices: ["No service on Memorial Day"]
    )

    public static func make(
        exceptionCode: String = sample.exceptionCode,
        patternId: String = sample.patternId,
        tripId: [String] = sample.tripId,
        operatingDays: String = sample.operatingDays,
        exceptionDates: [String] = sample.exceptionDates,
        exceptionNotices: [String] = sample.exceptionNotices
    ) -> ServiceException {
        ServiceException(exceptionCode: exceptionCode, patternId: patternId, tripId: tripId, operatingDays: operatingDays, exceptionDates: exceptionDates, exceptionNotices: exceptionNotices)
    }
}

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=DateException
public struct DateException: Codable, Sendable {
    /// Name of the route.
    public let routeId: String
    /// Collection of service exceptions.
    public let serviceExceptions: [ServiceException]

    public init(routeId: String, serviceExceptions: [ServiceException]) {
        self.routeId = routeId
        self.serviceExceptions = serviceExceptions
    }

    enum CodingKeys: String, CodingKey {
        case routeId = "RouteId"
        case serviceExceptions = "ServiceExceptions"
    }

    // MARK: - Mock Data

    public static let sample = DateException(
        routeId: "72",
        serviceExceptions: [ServiceException.sample]
    )

    public static func make(
        routeId: String = sample.routeId,
        serviceExceptions: [ServiceException] = sample.serviceExceptions
    ) -> DateException {
        DateException(routeId: routeId, serviceExceptions: serviceExceptions)
    }
}

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

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=TripScheduleStopTime
public struct TripScheduleStopTime: Codable, Sendable {
    /// Scheduled passing time for this stop.
    public let stopTime: String
    /// Unique identifier (ID511) for this stop.
    public let stopId: String
    public let placeId: String
    /// Estimated vehicle crowding at a stop. Values: `Crowded`, `Some Crowding`, or `Not Crowded`.
    public let occupancy: String

    public init(stopTime: String, stopId: String, placeId: String, occupancy: String) {
        self.stopTime = stopTime
        self.stopId = stopId
        self.placeId = placeId
        self.occupancy = occupancy
    }

    enum CodingKeys: String, CodingKey {
        case stopTime = "StopTime"
        case stopId = "StopId"
        case placeId = "PlaceId"
        case occupancy = "Occupancy"
    }

    // MARK: - Mock Data

    public static let sample = TripScheduleStopTime(
        stopTime: "2026-05-23T05:00:00",
        stopId: "51632",
        placeId: "2NWN",
        occupancy: "Not Crowded"
    )

    public static func make(
        stopTime: String = sample.stopTime,
        stopId: String = sample.stopId,
        placeId: String = sample.placeId,
        occupancy: String = sample.occupancy
    ) -> TripScheduleStopTime {
        TripScheduleStopTime(stopTime: stopTime, stopId: stopId, placeId: placeId, occupancy: occupancy)
    }
}

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=TripScheduleTrip
public struct TripScheduleTrip: Codable, Sendable {
    /// Scheduled start time of a trip.
    public let startTime: String
    /// Unique identifier of the pattern for this trip.
    public let patternId: String
    /// Set of unique trip identifiers that are associated with the current data set.
    public let tripId: [String]
    /// Trip status. Values: `OK` or `Canceled`.
    public let status: String
    /// Collection of scheduled times for stops.
    public let stopTimes: [TripScheduleStopTime]

    public init(startTime: String, patternId: String, tripId: [String], status: String, stopTimes: [TripScheduleStopTime]) {
        self.startTime = startTime
        self.patternId = patternId
        self.tripId = tripId
        self.status = status
        self.stopTimes = stopTimes
    }

    enum CodingKeys: String, CodingKey {
        case startTime = "StartTime"
        case patternId = "PatternId"
        case tripId = "TripId"
        case status = "Status"
        case stopTimes = "StopTimes"
    }

    // MARK: - Mock Data

    public static let sample = TripScheduleTrip(
        startTime: "05:00:00",
        patternId: "147",
        tripId: ["2305020"],
        status: "OK",
        stopTimes: [TripScheduleStopTime.sample]
    )

    public static func make(
        startTime: String = sample.startTime,
        patternId: String = sample.patternId,
        tripId: [String] = sample.tripId,
        status: String = sample.status,
        stopTimes: [TripScheduleStopTime] = sample.stopTimes
    ) -> TripScheduleTrip {
        TripScheduleTrip(startTime: startTime, patternId: patternId, tripId: tripId, status: status, stopTimes: stopTimes)
    }
}

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=TripScheduleRoute
public struct TripScheduleRoute: Codable, Sendable {
    /// Name of the route.
    public let routeId: String
    /// Direction of the route, normally a cardinal direction.
    public let lineDirection: String
    /// End of Line or destination for the requested route.
    public let lineDestination: String
    /// A collection with one or more strings that represent the type of schedule for the current data set.
    public let dayCode: [String]
    /// Description, in natural language, of the operating schedule.
    public let operatingDOW: String
    /// Collection of trip schedule information.
    public let trips: [TripScheduleTrip]

    public init(routeId: String, lineDirection: String, lineDestination: String, dayCode: [String], operatingDOW: String, trips: [TripScheduleTrip]) {
        self.routeId = routeId
        self.lineDirection = lineDirection
        self.lineDestination = lineDestination
        self.dayCode = dayCode
        self.operatingDOW = operatingDOW
        self.trips = trips
    }

    enum CodingKeys: String, CodingKey {
        case routeId = "RouteId"
        case lineDirection = "LineDirection"
        case lineDestination = "LineDestination"
        case dayCode = "DayCode"
        case operatingDOW = "OperatingDOW"
        case trips = "Trips"
    }

    // MARK: - Mock Data

    public static let sample = TripScheduleRoute(
        routeId: "72",
        lineDirection: "Northbound",
        lineDestination: "To Contra Costa College",
        dayCode: ["Weekday"],
        operatingDOW: "Mondays through Fridays except holidays",
        trips: [TripScheduleTrip.sample]
    )

    public static func make(
        routeId: String = sample.routeId,
        lineDirection: String = sample.lineDirection,
        lineDestination: String = sample.lineDestination,
        dayCode: [String] = sample.dayCode,
        operatingDOW: String = sample.operatingDOW,
        trips: [TripScheduleTrip] = sample.trips
    ) -> TripScheduleRoute {
        TripScheduleRoute(routeId: routeId, lineDirection: lineDirection, lineDestination: lineDestination, dayCode: dayCode, operatingDOW: operatingDOW, trips: trips)
    }
}

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=TripScheduleInfo
public struct TripScheduleInfo: Codable, Sendable {
    /// Unique id that represents a specific schedule name for the period of time associated with the requested data.
    public let bookingId: String
    /// Collection of route descriptions.
    public let routeProfiles: [RouteProfile]
    /// Collection of service date exceptions.
    public let dateExceptions: [DateException]
    /// Collection of stops for the requested routes.
    public let stops: [TripScheduleStop]
    /// Collection of route schedules.
    public let routes: [TripScheduleRoute]

    public init(bookingId: String, routeProfiles: [RouteProfile], dateExceptions: [DateException], stops: [TripScheduleStop], routes: [TripScheduleRoute]) {
        self.bookingId = bookingId
        self.routeProfiles = routeProfiles
        self.dateExceptions = dateExceptions
        self.stops = stops
        self.routes = routes
    }

    enum CodingKeys: String, CodingKey {
        case bookingId = "BookingId"
        case routeProfiles = "RouteProfiles"
        case dateExceptions = "DateExceptions"
        case stops = "Stops"
        case routes = "Routes"
    }

    // MARK: - Mock Data

    public static let sample = TripScheduleInfo(
        bookingId: "2604SP",
        routeProfiles: [RouteProfile.sample],
        dateExceptions: [],
        stops: [TripScheduleStop.sample],
        routes: [TripScheduleRoute.sample]
    )

    public static func make(
        bookingId: String = sample.bookingId,
        routeProfiles: [RouteProfile] = sample.routeProfiles,
        dateExceptions: [DateException] = sample.dateExceptions,
        stops: [TripScheduleStop] = sample.stops,
        routes: [TripScheduleRoute] = sample.routes
    ) -> TripScheduleInfo {
        TripScheduleInfo(bookingId: bookingId, routeProfiles: routeProfiles, dateExceptions: dateExceptions, stops: stops, routes: routes)
    }
}

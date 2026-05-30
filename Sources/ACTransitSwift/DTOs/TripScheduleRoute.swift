import Foundation

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

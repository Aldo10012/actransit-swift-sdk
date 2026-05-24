import EZNetworking
import Foundation

public enum RouteSortType: String {
    case alphabetical = "Alphabetical"
    case natural = "Natural"
}

public enum TripScheduleType: Int, Codable, Sendable {
    case weekday = 0
    case saturday = 5
    case sunday = 6

    /// String value used when passing this type as a query parameter.
    var queryValue: String {
        switch self {
        case .weekday: "Weekday"
        case .saturday: "Saturday"
        case .sunday: "Sunday"
        }
    }
}

enum RoutesEndpoint {
    /// https://api.actransit.org/transit/routes/{booking}?sortType={sortType}
    /// - Parameters:
    ///   - booking: Unique id representing a specific schedule. Use `Current` or `nil` for the current schedule, `Next` for the next schedule, or a specific BookingId.
    ///   - sortType: Indicates how the routes should be sorted. Default is natural sort. Options: `Alphabetical` or `Natural`.
    case routes(booking: String? = nil, sortType: RouteSortType? = nil)
    /// https://api.actransit.org/transit/route/{routeName}/{booking}
    /// - Parameters:
    ///   - routeName: The route to be retrieved.
    ///   - booking: Schedule identifier. Use `Current` or `nil` for the current schedule, `Next` for the next, or a specific BookingId.
    case route(routeName: String, booking: String? = nil)
    /// https://api.actransit.org/transit/route/{routeName}/trips
    /// - Parameters:
    ///   - routeName: The route identifier.
    ///   - direction: Filter results by direction of travel.
    ///   - scheduleType: Filter by schedule type: `Weekday`, `Saturday`, or `Sunday`.
    case trips(routeName: String, direction: String? = nil, scheduleType: TripScheduleType? = nil)
    /// https://api.actransit.org/transit/route/{routeName}/tripsinstructions
    /// - Parameters:
    ///   - routeName: The route identifier.
    ///   - direction: Filter by direction of travel.
    ///   - scheduleType: Required. The schedule type: `Weekday`, `Saturday`, or `Sunday`.
    case tripsInstructions(routeName: String, direction: String? = nil, scheduleType: TripScheduleType)
    /// https://api.actransit.org/transit/route/{routeName}/directions
    /// - Parameters:
    ///   - routeName: The route identifier.
    case directions(routeName: String)
    /// https://api.actransit.org/transit/route/{routeName}/stops/{booking}
    /// - Parameters:
    ///   - routeName: The route identifier.
    ///   - booking: Schedule identifier. Use `Current` or `nil` for the current schedule, `Next` for the next, or a specific BookingId.
    ///   - direction: Filter by direction.
    ///   - destination: Filter by destination; should match actrealtime API values.
    ///   - scheduleType: Filter by schedule type: `Today`, `Saturday`, `Sunday`, or `Weekday`.
    ///   - byPattern: If true, return stops per stop pattern. Default false.
    case stops(routeName: String, booking: String? = nil, direction: String? = nil, destination: String? = nil, scheduleType: TripScheduleType? = nil, byPattern: Bool? = nil)
    /// https://api.actransit.org/transit/route/{routeName}/trip/{tripId}/pattern
    /// - Parameters:
    ///   - routeName: The route identifier.
    ///   - tripId: The trip identifier.
    case pattern(routeName: String, tripId: Int)
    /// https://api.actransit.org/transit/route/{routeName}/trip/{tripId}/stops
    /// - Parameters:
    ///   - routeName: The route identifier.
    ///   - tripId: The trip identifier.
    case tripStops(routeName: String, tripId: Int)
    /// https://api.actransit.org/transit/route/{routeName}/vehicles
    /// - Parameters:
    ///   - routeName: The route identifier.
    case vehicles(routeName: String)
    /// https://api.actransit.org/transit/route/{routeName}/tripestimate?fromStopId={fromStopId}&toStopId={toStopId}
    /// - Parameters:
    ///   - routeName: The route identifier.
    ///   - fromStopId: The origin stop identifier.
    ///   - toStopId: The destination stop identifier.
    case tripEstimate(routeName: String, fromStopId: Int, toStopId: Int)
    /// https://api.actransit.org/transit/route/{routes}/waypoints/{booking}?scheduleType={scheduleType}
    /// - Parameters:
    ///   - routes: Comma-delimited route identifiers, or `all`.
    ///   - booking: Schedule identifier. Use `Current` or `nil` for the current schedule, `Next` for the next, or a specific BookingId.
    ///   - scheduleType: Filter by schedule type: `Weekday`, `Saturday`, or `Sunday`.
    case waypoints(routes: String, booking: String? = nil, scheduleType: TripScheduleType? = nil)
    /// https://api.actransit.org/transit/route/{routes}/waypointsfast/{booking}?scheduleType={scheduleType}
    /// - Parameters:
    ///   - routes: Comma-delimited route identifiers, or `all`.
    ///   - booking: Schedule identifier. Use `Current` or `nil` for the current schedule, `Next` for the next, or a specific BookingId.
    ///   - scheduleType: Filter by schedule type: `Weekday`, `Saturday`, or `Sunday`.
    case waypointsFast(routes: String, booking: String? = nil, scheduleType: TripScheduleType? = nil)
    /// https://api.actransit.org/transit/route/{routes}/tripstoday?direction={direction}
    /// - Parameters:
    ///   - routes: Comma-delimited route identifiers.
    ///   - direction: Optional direction or destination to filter by (comma delimited).
    case tripsToday(routes: String, direction: String? = nil)
    /// https://api.actransit.org/transit/route/{routes}/tripstops?direction={direction}
    /// - Parameters:
    ///   - routes: Comma-delimited route identifiers.
    ///   - direction: Optional direction or destination to filter by (comma delimited).
    case tripStopsToday(routes: String, direction: String? = nil)
    /// https://api.actransit.org/transit/route/{routes}/timetable/{direction}?dayCode={dayCode}&hasAllStops={hasAllStops}
    /// - Parameters:
    ///   - routes: Comma-delimited route identifiers.
    ///   - direction: Direction or destination designation.
    ///   - dayCode: Day type: `Weekday`, `Saturday`, or `Sunday`. Defaults to current day.
    ///   - hasAllStops: If true, include all stops rather than major locations only. Default false.
    case timetable(routes: String, direction: String? = nil, dayCode: String? = nil, hasAllStops: Bool? = nil)
    /// https://api.actransit.org/transit/route/{routes}/schedule/{booking}?direction={direction}&destination={destination}&dayCode={dayCode}&hasAllStops={hasAllStops}&stopId={stopId}
    /// - Parameters:
    ///   - routes: Comma-delimited route identifiers.
    ///   - booking: Schedule identifier. Use `Current` or `nil` for the current schedule, `Next` for the next, or a specific BookingId.
    ///   - direction: Optional route direction.
    ///   - destination: Optional route destination.
    ///   - dayCode: Day type: `Weekday`, `Saturday`, or `Sunday`. Defaults to today.
    ///   - hasAllStops: If true, include waypoints. Default false.
    ///   - stopId: Filter results to a specific stop by ID511 code.
    case schedule(routes: String, booking: String? = nil, direction: String? = nil, destination: String? = nil, dayCode: String? = nil, hasAllStops: Bool? = nil, stopId: String? = nil)
    /// https://api.actransit.org/transit/route/{routeName}/destinations
    /// - Parameters:
    ///   - routeName: The route identifier.
    case destinations(routeName: String)
    /// https://api.actransit.org/transit/route/{routes}/exceptions/{booking}
    /// - Parameters:
    ///   - routes: Comma-delimited route identifiers, or `all`.
    ///   - booking: Schedule identifier. Use `Current` or `nil` for the current schedule, `Next` for the next, or a specific BookingId.
    case exceptions(routes: String, booking: String? = nil)
    /// https://api.actransit.org/transit/route/{routes}/profile
    /// - Parameters:
    ///   - routes: Comma-separated list of route identifiers, or `all`.
    case profile(routes: String)
}

extension RoutesEndpoint {
    var path: String {
        switch self {
        case let .routes(booking, _):
            if let booking {
                "/routes/\(booking)"
            } else {
                "/routes"
            }
        case let .route(routeName, booking):
            if let booking {
                "/route/\(routeName)/\(booking)"
            } else {
                "/route/\(routeName)"
            }
        case let .trips(routeName, _, _):
            "/route/\(routeName)/trips"
        case let .tripsInstructions(routeName, _, _):
            "/route/\(routeName)/tripsinstructions"
        case let .directions(routeName):
            "/route/\(routeName)/directions"
        case let .stops(routeName, booking, _, _, _, _):
            if let booking {
                "/route/\(routeName)/stops/\(booking)"
            } else {
                "/route/\(routeName)/stops"
            }
        case let .pattern(routeName, tripId):
            "/route/\(routeName)/trip/\(tripId)/pattern"
        case let .tripStops(routeName, tripId):
            "/route/\(routeName)/trip/\(tripId)/stops"
        case let .vehicles(routeName):
            "/route/\(routeName)/vehicles"
        case let .tripEstimate(routeName, _, _):
            "/route/\(routeName)/tripestimate"
        case let .waypoints(routes, booking, _):
            if let booking {
                "/route/\(routes)/waypoints/\(booking)"
            } else {
                "/route/\(routes)/waypoints"
            }
        case let .waypointsFast(routes, booking, _):
            if let booking {
                "/route/\(routes)/waypointsfast/\(booking)"
            } else {
                "/route/\(routes)/waypointsfast"
            }
        case let .tripsToday(routes, _):
            "/route/\(routes)/tripstoday"
        case let .tripStopsToday(routes, _):
            "/route/\(routes)/tripstops"
        case let .timetable(routes, direction, _, _):
            if let direction {
                "/route/\(routes)/timetable/\(direction)"
            } else {
                "/route/\(routes)/timetable"
            }
        case let .schedule(routes, booking, _, _, _, _, _):
            if let booking {
                "/route/\(routes)/schedule/\(booking)"
            } else {
                "/route/\(routes)/schedule"
            }
        case let .destinations(routeName):
            "/route/\(routeName)/destinations"
        case let .exceptions(routes, booking):
            if let booking {
                "/route/\(routes)/exceptions/\(booking)"
            } else {
                "/route/\(routes)/exceptions"
            }
        case let .profile(routes):
            "/route/\(routes)/profile"
        }
    }

    // swiftlint:disable:next cyclomatic_complexity
    func getRequest(token: String) -> Request {
        let factory = RequestFactoryImpl()
        let url = ACTransitPlugins.apiBaseURL + path
        let tokenParam = HTTPParameter(key: Constants.tokenKey, value: token)

        switch self {
        case let .routes(_, sortType):
            var params: [HTTPParameter] = [tokenParam]
            if let sortType {
                params.append(HTTPParameter(key: "sortType", value: sortType.rawValue))
            }
            return factory.build(httpMethod: .GET, baseUrlString: url, parameters: params)
        case .route:
            return factory.build(httpMethod: .GET, baseUrlString: url, parameters: [tokenParam])
        case let .trips(_, direction, scheduleType):
            var params: [HTTPParameter] = [tokenParam]
            if let direction {
                params.append(HTTPParameter(key: "direction", value: direction))
            }
            if let scheduleType {
                params.append(HTTPParameter(key: "scheduleType", value: scheduleType.queryValue))
            }
            return factory.build(httpMethod: .GET, baseUrlString: url, parameters: params)
        case let .tripsInstructions(_, direction, scheduleType):
            var params: [HTTPParameter] = [tokenParam]
            if let direction {
                params.append(HTTPParameter(key: "direction", value: direction))
            }
            params.append(HTTPParameter(key: "scheduleType", value: scheduleType.queryValue))
            return factory.build(httpMethod: .GET, baseUrlString: url, parameters: params)
        case .directions:
            return factory.build(httpMethod: .GET, baseUrlString: url, parameters: [tokenParam])
        case let .stops(_, _, direction, destination, scheduleType, byPattern):
            var params: [HTTPParameter] = [tokenParam]
            if let direction {
                params.append(HTTPParameter(key: "direction", value: direction))
            }
            if let destination {
                params.append(HTTPParameter(key: "destination", value: destination))
            }
            if let scheduleType {
                params.append(HTTPParameter(key: "scheduleType", value: scheduleType.queryValue))
            }
            if let byPattern {
                params.append(HTTPParameter(key: "byPattern", value: String(byPattern)))
            }
            return factory.build(httpMethod: .GET, baseUrlString: url, parameters: params)
        case .pattern:
            return factory.build(httpMethod: .GET, baseUrlString: url, parameters: [tokenParam])
        case .tripStops:
            return factory.build(httpMethod: .GET, baseUrlString: url, parameters: [tokenParam])
        case .vehicles:
            return factory.build(httpMethod: .GET, baseUrlString: url, parameters: [tokenParam])
        case let .tripEstimate(_, fromStopId, toStopId):
            let params: [HTTPParameter] = [
                tokenParam,
                HTTPParameter(key: "fromStopId", value: String(fromStopId)),
                HTTPParameter(key: "toStopId", value: String(toStopId))
            ]
            return factory.build(httpMethod: .GET, baseUrlString: url, parameters: params)
        case let .waypoints(_, _, scheduleType):
            var params: [HTTPParameter] = [tokenParam]
            if let scheduleType {
                params.append(HTTPParameter(key: "scheduleType", value: scheduleType.queryValue))
            }
            return factory.build(httpMethod: .GET, baseUrlString: url, parameters: params)
        case let .waypointsFast(_, _, scheduleType):
            var params: [HTTPParameter] = [tokenParam]
            if let scheduleType {
                params.append(HTTPParameter(key: "scheduleType", value: scheduleType.queryValue))
            }
            return factory.build(httpMethod: .GET, baseUrlString: url, parameters: params)
        case let .tripsToday(_, direction):
            var params: [HTTPParameter] = [tokenParam]
            if let direction {
                params.append(HTTPParameter(key: "direction", value: direction))
            }
            return factory.build(httpMethod: .GET, baseUrlString: url, parameters: params)
        case let .tripStopsToday(_, direction):
            var params: [HTTPParameter] = [tokenParam]
            if let direction {
                params.append(HTTPParameter(key: "direction", value: direction))
            }
            return factory.build(httpMethod: .GET, baseUrlString: url, parameters: params)
        case let .timetable(_, _, dayCode, hasAllStops):
            var params: [HTTPParameter] = [tokenParam]
            if let dayCode {
                params.append(HTTPParameter(key: "dayCode", value: dayCode))
            }
            if let hasAllStops {
                params.append(HTTPParameter(key: "hasAllStops", value: String(hasAllStops)))
            }
            return factory.build(httpMethod: .GET, baseUrlString: url, parameters: params)
        case let .schedule(_, _, direction, destination, dayCode, hasAllStops, stopId):
            var params: [HTTPParameter] = [tokenParam]
            if let direction {
                params.append(HTTPParameter(key: "direction", value: direction))
            }
            if let destination {
                params.append(HTTPParameter(key: "destination", value: destination))
            }
            if let dayCode {
                params.append(HTTPParameter(key: "dayCode", value: dayCode))
            }
            if let hasAllStops {
                params.append(HTTPParameter(key: "hasAllStops", value: String(hasAllStops)))
            }
            if let stopId {
                params.append(HTTPParameter(key: "stopId", value: stopId))
            }
            return factory.build(httpMethod: .GET, baseUrlString: url, parameters: params)
        case .destinations:
            return factory.build(httpMethod: .GET, baseUrlString: url, parameters: [tokenParam])
        case .exceptions:
            return factory.build(httpMethod: .GET, baseUrlString: url, parameters: [tokenParam])
        case .profile:
            return factory.build(httpMethod: .GET, baseUrlString: url, parameters: [tokenParam])
        }
    }

    enum Constants {
        static let tokenKey = "token"
    }
}

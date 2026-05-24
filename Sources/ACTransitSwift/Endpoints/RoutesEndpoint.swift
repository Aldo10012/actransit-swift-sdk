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
        }
    }

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
        }
    }

    enum Constants {
        static let tokenKey = "token"
    }
}

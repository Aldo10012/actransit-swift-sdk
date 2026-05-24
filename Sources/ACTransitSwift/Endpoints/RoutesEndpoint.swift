import EZNetworking
import Foundation

public enum RouteSortType: String {
    case alphabetical = "Alphabetical"
    case natural = "Natural"
}

enum RoutesEndpoint {
    /// https://api.actransit.org/transit/routes/{booking}?sortType={sortType}
    /// - Parameters:
    ///   - booking: Unique id representing a specific schedule. Use `Current` or `nil` for the current schedule, `Next` for the next schedule, or a specific BookingId.
    ///   - sortType: Indicates how the routes should be sorted. Default is natural sort. Options: `Alphabetical` or `Natural`.
    case routes(booking: String? = nil, sortType: RouteSortType? = nil)
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
        }
    }

    enum Constants {
        static let tokenKey = "token"
    }
}

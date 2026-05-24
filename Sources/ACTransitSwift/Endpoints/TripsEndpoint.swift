import EZNetworking
import Foundation

enum TripsEndpoint {
    /// https://api.actransit.org/transit/Help/Api/GET-trips-canceled
    /// - Parameters:
    ///   - lastIncidentUniqueId: Filter results to a specific incident by its unique ID.
    ///   - lastOpenDateTime: Filter by the date/time the incident was opened.
    ///   - tripDateTimeFrom: Start of the trip date/time range to filter by.
    ///   - tripDateTimeTo: End of the trip date/time range to filter by.
    case canceled(
        lastIncidentUniqueId: Int? = nil,
        lastOpenDateTime: Date? = nil,
        tripDateTimeFrom: Date? = nil,
        tripDateTimeTo: Date? = nil
    )
    /// https://api.actransit.org/transit/Help/Api/GET-trips-tripcancellationinfo-tripNumber
    /// - Parameters:
    ///   - tripNumber: The trip identifier whose cancellation details should be retrieved.
    case cancellationInfo(tripNumber: Int)
}

extension TripsEndpoint {
    var path: String {
        switch self {
        case .canceled: "/trips/canceled"
        case let .cancellationInfo(tripNumber): "/trips/tripcancellationinfo/\(tripNumber)"
        }
    }

    func getRequest(token: String) -> Request {
        let factory = RequestFactoryImpl()
        let url = ACTransitPlugins.apiBaseURL + path
        let tokenParam = HTTPParameter(key: Constants.tokenKey, value: token)

        switch self {
        case let .canceled(lastIncidentUniqueId, lastOpenDateTime, tripDateTimeFrom, tripDateTimeTo):
            var params: [HTTPParameter] = [tokenParam]
            if let lastIncidentUniqueId {
                params.append(HTTPParameter(key: "lastIncidentUniqueId", value: String(lastIncidentUniqueId)))
            }
            if let lastOpenDateTime {
                params.append(HTTPParameter(key: "lastOpenDateTime", value: ISO8601DateFormatter.ACTQueryFormat.string(from: lastOpenDateTime)))
            }
            if let tripDateTimeFrom {
                params.append(HTTPParameter(key: "tripDateTimeFrom", value: ISO8601DateFormatter.ACTQueryFormat.string(from: tripDateTimeFrom)))
            }
            if let tripDateTimeTo {
                params.append(HTTPParameter(key: "tripDateTimeTo", value: ISO8601DateFormatter.ACTQueryFormat.string(from: tripDateTimeTo)))
            }
            return factory.build(httpMethod: .GET, baseUrlString: url, parameters: params)
        case .cancellationInfo:
            return factory.build(httpMethod: .GET, baseUrlString: url, parameters: [tokenParam])
        }
    }

    enum Constants {
        static let tokenKey = "token"
    }
}

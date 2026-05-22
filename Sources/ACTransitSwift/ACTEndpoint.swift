import EZNetworking
import Foundation

public enum ACTEndpoint {
    /// https://api.actransit.org/transit/Help/Api/GET-gtfs
    case gtfs
    /// https://api.actransit.org/transit/Help/Api/GET-gtfs-all
    case gtfsAll
    /// https://api.actransit.org/transit/Help/Api/GET-trips-canceled
    case tripsCanceled(
        lastIncidentUniqueId: Int? = nil,
        lastOpenDateTime: Date? = nil,
        tripDateTimeFrom: Date? = nil,
        tripDateTimeTo: Date? = nil
    )
    /// https://api.actransit.org/transit/Help/Api/GET-trips-tripcancellationinfo-tripNumber
    case tripsTripCancellationInfo(tripNumber: Int)
}

extension ACTEndpoint {
    var path: String {
        switch self {
        case .gtfs: "/gtfs"
        case .gtfsAll: "/gtfs/all"
        case .tripsCanceled: "/trips/canceled"
        case let .tripsTripCancellationInfo(tripNumber): "/trips/tripcancellationinfo/\(tripNumber)"
        }
    }

    func getRequest(token: String) -> Request {
        let factory = RequestFactoryImpl()
        let url = ACTransitPlugins.apiBaseURL + path
        let apiTokenQueryParameter = HTTPParameter(key: Constants.tokenKey, value: token)

        switch self {
        case .gtfs:
            return factory.build(httpMethod: .GET, baseUrlString: url, parameters: [apiTokenQueryParameter])
        case .gtfsAll:
            return factory.build(httpMethod: .GET, baseUrlString: url, parameters: [apiTokenQueryParameter])
        case let .tripsCanceled(lastIncidentUniqueId, lastOpenDateTime, tripDateTimeFrom, tripDateTimeTo):
            var params: [HTTPParameter] = [apiTokenQueryParameter]
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
        case .tripsTripCancellationInfo:
            return factory.build(httpMethod: .GET, baseUrlString: url, parameters: [apiTokenQueryParameter])
        }
    }

    enum Constants {
        static let tokenKey = "token"
    }
}

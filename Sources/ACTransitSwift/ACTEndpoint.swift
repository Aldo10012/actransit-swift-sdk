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
}

extension ACTEndpoint {
    var path: String {
        switch self {
        case .gtfs: "/gtfs"
        case .gtfsAll: "/gtfs/all"
        case .tripsCanceled: "/trips/canceled"
        }
    }

    func getRequest() -> Request {
        let factory = RequestFactoryImpl()
        let url = ACTSwiftPlugins.apiBaseURL + path
        let apiTokenQueryParameter = HTTPParameter(key: Constants.tokenKey, value: ACTSwiftPlugins.apiToken)

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
                params.append(HTTPParameter(key: "lastOpenDateTime", value: Self.queryDateFormatter.string(from: lastOpenDateTime)))
            }
            if let tripDateTimeFrom {
                params.append(HTTPParameter(key: "tripDateTimeFrom", value: Self.queryDateFormatter.string(from: tripDateTimeFrom)))
            }
            if let tripDateTimeTo {
                params.append(HTTPParameter(key: "tripDateTimeTo", value: Self.queryDateFormatter.string(from: tripDateTimeTo)))
            }
            return factory.build(httpMethod: .GET, baseUrlString: url, parameters: params)
        }
    }

    enum Constants {
        static let tokenKey = "token"
    }

    private nonisolated(unsafe) static let queryDateFormatter: ISO8601DateFormatter = {
        let f = ISO8601DateFormatter()
        f.formatOptions = [.withInternetDateTime]
        return f
    }()
}

import EZNetworking
import Foundation

public enum ACTEndpoint {
    // https://api.actransit.org/transit/Help/Api/GET-gtfs
    case gtfs
    // https://api.actransit.org/transit/Help/Api/GET-gtfs-all
    case gtfsAll
}

extension ACTEndpoint {
    var path: String {
        switch self {
        case .gtfs: "/gtfs"
        case .gtfsAll: "/gtfs/all"
        }
    }

    func getRequest() -> Request {
        let factory = RequestFactoryImpl()
        let url = ACTSwiftPlugins.apiBaseURL + path
        let apiTokenQueryParameter = HTTPParameter(key: Constants.tokenKey, value: ACTSwiftPlugins.apiToken)

        return switch self {
        case .gtfs:
            factory.build(httpMethod: .GET, baseUrlString: url, parameters: [apiTokenQueryParameter])
        case .gtfsAll:
            factory.build(httpMethod: .GET, baseUrlString: url, parameters: [apiTokenQueryParameter])
        }
    }

    enum Constants {
        static let tokenKey = "token"
    }
}

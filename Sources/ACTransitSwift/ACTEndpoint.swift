import EZNetworking
import Foundation

public enum ACTEndpoint {
    case gtfs
}

extension ACTEndpoint {
    var path: String {
        return switch self {
        case .gtfs: "/gtfs"
        }
    }

    func getRequest() -> Request {
        let factory = RequestFactoryImpl()
        let url = ACTSwiftPlugins.apiBaseURL + path
        let apiTokenQueryParameter = HTTPParameter(key: Constants.tokenKey, value: ACTSwiftPlugins.apiToken)

        return switch self {
        case .gtfs:
            factory.build(httpMethod: .GET, baseUrlString: url, parameters: [apiTokenQueryParameter])
        }
    }

    enum Constants {
        static let tokenKey = "token"
    }
}

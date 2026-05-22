import EZNetworking
import Foundation

enum GTFSEndpoint {
    /// https://api.actransit.org/transit/Help/Api/GET-gtfs
    case active
    /// https://api.actransit.org/transit/Help/Api/GET-gtfs-all
    case all
}

extension GTFSEndpoint {
    var path: String {
        switch self {
        case .active: "/gtfs"
        case .all: "/gtfs/all"
        }
    }

    func getRequest(token: String) -> Request {
        let factory = RequestFactoryImpl()
        let url = ACTransitPlugins.apiBaseURL + path
        let tokenParam = HTTPParameter(key: Constants.tokenKey, value: token)
        return factory.build(httpMethod: .GET, baseUrlString: url, parameters: [tokenParam])
    }

    enum Constants {
        static let tokenKey = "token"
    }
}

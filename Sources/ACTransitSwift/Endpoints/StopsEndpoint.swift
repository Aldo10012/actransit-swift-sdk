import EZNetworking
import Foundation

enum StopsEndpoint {
    /// https://api.actransit.org/transit/stops
    case allStops
}

extension StopsEndpoint {
    var path: String {
        switch self {
        case .allStops: "/stops"
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

import EZNetworking
import Foundation

enum VehicleEndpoint {
    /// https://api.actransit.org/transit/vehicle/{vehicleId}
    /// - Parameters:
    ///   - vehicleId: Vehicle identifier.
    case vehicle(vehicleId: Int)
}

extension VehicleEndpoint {
    var path: String {
        switch self {
        case let .vehicle(vehicleId):
            "/vehicle/\(vehicleId)"
        }
    }

    func getRequest(token: String) -> Request {
        let factory = RequestFactoryImpl()
        let url = ACTransitPlugins.apiBaseURL + path
        let tokenParam = HTTPParameter(key: Constants.tokenKey, value: token)
        switch self {
        case .vehicle:
            return factory.build(httpMethod: .GET, baseUrlString: url, parameters: [tokenParam])
        }
    }

    enum Constants {
        static let tokenKey = "token"
    }
}

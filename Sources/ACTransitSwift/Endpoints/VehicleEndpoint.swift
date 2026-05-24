import EZNetworking
import Foundation

enum VehicleEndpoint {
    /// https://api.actransit.org/transit/vehicle/{vehicleId}
    /// - Parameters:
    ///   - vehicleId: Vehicle identifier.
    case vehicle(vehicleId: Int)
    /// https://api.actransit.org/transit/vehicle/characteristics?vehicleId={vehicleId}
    /// - Parameters:
    ///   - vehicleId: Alphanumeric string representing the vehicle ID (ie. bus number); omit to retrieve all active vehicles.
    case characteristics(vehicleId: String? = nil)
    /// https://api.actransit.org/transit/vehicle/{vehicleId}/characteristics
    /// - Parameters:
    ///   - vehicleId: Vehicle (bus) number.
    case vehicleCharacteristics(vehicleId: String)
}

extension VehicleEndpoint {
    var path: String {
        switch self {
        case let .vehicle(vehicleId):
            "/vehicle/\(vehicleId)"
        case .characteristics:
            "/vehicle/characteristics"
        case let .vehicleCharacteristics(vehicleId):
            "/vehicle/\(vehicleId)/characteristics"
        }
    }

    func getRequest(token: String) -> Request {
        let factory = RequestFactoryImpl()
        let url = ACTransitPlugins.apiBaseURL + path
        let tokenParam = HTTPParameter(key: Constants.tokenKey, value: token)
        switch self {
        case .vehicle:
            return factory.build(httpMethod: .GET, baseUrlString: url, parameters: [tokenParam])
        case let .characteristics(vehicleId):
            var params: [HTTPParameter] = [tokenParam]
            if let vehicleId {
                params.append(HTTPParameter(key: "vehicleId", value: vehicleId))
            }
            return factory.build(httpMethod: .GET, baseUrlString: url, parameters: params)
        case .vehicleCharacteristics:
            return factory.build(httpMethod: .GET, baseUrlString: url, parameters: [tokenParam])
        }
    }

    enum Constants {
        static let tokenKey = "token"
    }
}

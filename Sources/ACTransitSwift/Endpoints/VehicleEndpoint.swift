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
    /// https://api.actransit.org/transit/vehicle/realtimeattributes?vehicleId={vehicleId}&routename={routename}
    /// - Parameters:
    ///   - vehicleId: Vehicle (bus) number filter.
    ///   - routeName: Route name filter.
    case realtimeAttributes(vehicleId: String? = nil, routeName: String? = nil)
    /// https://api.actransit.org/transit/vehicle/{vehicleId}/realtimeattributes?routename={routename}
    /// - Parameters:
    ///   - vehicleId: Vehicle (bus) number.
    ///   - routeName: Name of the route that the vehicle is currently servicing.
    case vehicleRealtimeAttributes(vehicleId: String, routeName: String? = nil)
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
        case .realtimeAttributes:
            "/vehicle/realtimeattributes"
        case let .vehicleRealtimeAttributes(vehicleId, _):
            "/vehicle/\(vehicleId)/realtimeattributes"
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
        case let .realtimeAttributes(vehicleId, routeName):
            var params: [HTTPParameter] = [tokenParam]
            if let vehicleId {
                params.append(HTTPParameter(key: "vehicleId", value: vehicleId))
            }
            if let routeName {
                params.append(HTTPParameter(key: "routename", value: routeName))
            }
            return factory.build(httpMethod: .GET, baseUrlString: url, parameters: params)
        case let .vehicleRealtimeAttributes(_, routeName):
            var params: [HTTPParameter] = [tokenParam]
            if let routeName {
                params.append(HTTPParameter(key: "routename", value: routeName))
            }
            return factory.build(httpMethod: .GET, baseUrlString: url, parameters: params)
        }
    }

    enum Constants {
        static let tokenKey = "token"
    }
}

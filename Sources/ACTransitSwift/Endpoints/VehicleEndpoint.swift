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
    /// https://api.actransit.org/transit/vehicle/route/{routename}/realtimeattributes?vehicleId={vehicleId}
    /// - Parameters:
    ///   - routeName: Route name identifier.
    ///   - vehicleId: Optional vehicle ID filter.
    case routeRealtimeAttributes(routeName: String, vehicleId: String? = nil)
    /// https://api.actransit.org/transit/vehicle/realtimeattributes
    /// - Parameters:
    ///   - vehicles: Collection of vehicle IDs (bus numbers).
    ///   - route: Route name (e.g., `72`).
    case bulkRealtimeAttributes(vehicles: [String], route: String? = nil)
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
        case let .routeRealtimeAttributes(routeName, _):
            "/vehicle/route/\(routeName)/realtimeattributes"
        case .bulkRealtimeAttributes:
            "/vehicle/realtimeattributes"
        }
    }

    // swiftlint:disable:next cyclomatic_complexity
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
        case let .routeRealtimeAttributes(_, vehicleId):
            var params: [HTTPParameter] = [tokenParam]
            if let vehicleId {
                params.append(HTTPParameter(key: "vehicleId", value: vehicleId))
            }
            return factory.build(httpMethod: .GET, baseUrlString: url, parameters: params)
        case let .bulkRealtimeAttributes(vehicles, route):
            let bodyData = try? JSONEncoder().encode(BulkRealtimeAttributesBody(vehicles: vehicles, route: route))
            return factory.build(httpMethod: .POST, baseUrlString: url, parameters: [tokenParam], headers: [.contentType(.json)], body: bodyData)
        }
    }

    enum Constants {
        static let tokenKey = "token"
    }
}

private struct BulkRealtimeAttributesBody: Encodable {
    let vehicles: [String]
    let route: String?

    enum CodingKeys: String, CodingKey {
        case vehicles = "Vehicles"
        case route = "Route"
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(vehicles, forKey: .vehicles)
        try container.encodeIfPresent(route, forKey: .route)
    }
}

import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=DateException
public struct DateException: Codable, Sendable {
    /// Name of the route.
    public let routeId: String
    /// Collection of service exceptions.
    public let serviceExceptions: [ServiceException]

    public init(routeId: String, serviceExceptions: [ServiceException]) {
        self.routeId = routeId
        self.serviceExceptions = serviceExceptions
    }

    enum CodingKeys: String, CodingKey {
        case routeId = "RouteId"
        case serviceExceptions = "ServiceExceptions"
    }

    // MARK: - Mock Data

    public static let sample = DateException(
        routeId: "72",
        serviceExceptions: [ServiceException.sample]
    )

    public static func make(
        routeId: String = sample.routeId,
        serviceExceptions: [ServiceException] = sample.serviceExceptions
    ) -> DateException {
        DateException(routeId: routeId, serviceExceptions: serviceExceptions)
    }
}

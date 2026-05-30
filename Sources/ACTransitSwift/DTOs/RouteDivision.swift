import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=RouteDivision
public struct RouteDivision: Codable, Sendable {
    /// Route's unique identifier
    public let routeId: String
    /// The Route's name as seen by the public
    public let name: String
    /// The division that this route belongs to
    public let division: String
    /// Additional information regarding the route
    public let description: String
    /// True if is a local route (non transbay), false otherwise
    public let isLocal: Bool
    /// True if is a Transbay route, false otherwise
    public let isTransbay: Bool
    /// True if it is a Rapid route, false otherwise
    public let isRapid: Bool
    /// True if it is an All Nighter route, false otherwise
    public let isAllNighter: Bool
    /// True if it is a School route, false otherwise
    public let isSchool: Bool

    public init(
        routeId: String,
        name: String,
        division: String,
        description: String,
        isLocal: Bool,
        isTransbay: Bool,
        isRapid: Bool,
        isAllNighter: Bool,
        isSchool: Bool
    ) {
        self.routeId = routeId
        self.name = name
        self.division = division
        self.description = description
        self.isLocal = isLocal
        self.isTransbay = isTransbay
        self.isRapid = isRapid
        self.isAllNighter = isAllNighter
        self.isSchool = isSchool
    }

    enum CodingKeys: String, CodingKey {
        case routeId = "RouteId"
        case name = "Name"
        case division = "Division"
        case description = "Description"
        case isLocal = "IsLocal"
        case isTransbay = "IsTransbay"
        case isRapid = "IsRapid"
        case isAllNighter = "IsAllNighter"
        case isSchool = "IsSchool"
    }

    // MARK: - Mock Data

    public static let sample = RouteDivision(
        routeId: "1T",
        name: "1T",
        division: "D4",
        description: "International - E. 14th",
        isLocal: true,
        isTransbay: false,
        isRapid: false,
        isAllNighter: false,
        isSchool: false
    )

    public static func make(
        routeId: String = sample.routeId,
        name: String = sample.name,
        division: String = sample.division,
        description: String = sample.description,
        isLocal: Bool = sample.isLocal,
        isTransbay: Bool = sample.isTransbay,
        isRapid: Bool = sample.isRapid,
        isAllNighter: Bool = sample.isAllNighter,
        isSchool: Bool = sample.isSchool
    ) -> RouteDivision {
        RouteDivision(
            routeId: routeId,
            name: name,
            division: division,
            description: description,
            isLocal: isLocal,
            isTransbay: isTransbay,
            isRapid: isRapid,
            isAllNighter: isAllNighter,
            isSchool: isSchool
        )
    }
}

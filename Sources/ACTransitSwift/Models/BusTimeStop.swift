import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=Stop
public struct BusTimeStop: Codable, Sendable {
    /// Unique identifier representing the stop.
    public let stpid: String
    /// Display name of the stop.
    public let stpnm: String
    /// Latitude position of the stop in decimal degrees (WGS 84).
    public let lat: Double
    /// Longitude position of the stop in decimal degrees (WGS 84).
    public let lon: Double
    /// Detour IDs for detours that added this stop to the route.
    public let dtradd: [String]?
    /// Detour IDs for detours that removed this stop from the route.
    public let dtrrem: [String]?

    public init(stpid: String, stpnm: String, lat: Double, lon: Double, dtradd: [String]? = nil, dtrrem: [String]? = nil) {
        self.stpid = stpid
        self.stpnm = stpnm
        self.lat = lat
        self.lon = lon
        self.dtradd = dtradd
        self.dtrrem = dtrrem
    }

    // MARK: - Mock Data

    public static let sample = BusTimeStop(
        stpid: "55123",
        stpnm: "Telegraph Ave & Ashby Ave",
        lat: 37.8558,
        lon: -122.2597
    )

    public static func make(
        stpid: String = sample.stpid,
        stpnm: String = sample.stpnm,
        lat: Double = sample.lat,
        lon: Double = sample.lon,
        dtradd: [String]? = sample.dtradd,
        dtrrem: [String]? = sample.dtrrem
    ) -> BusTimeStop {
        BusTimeStop(stpid: stpid, stpnm: stpnm, lat: lat, lon: lon, dtradd: dtradd, dtrrem: dtrrem)
    }
}

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=StopRequestResponse
public struct StopRequestResponse: Codable, Sendable {
    /// Stops matching the request.
    public let stops: [BusTimeStop]
    /// Errors from request processing.
    public let error: [BusTimeError]?

    public init(stops: [BusTimeStop], error: [BusTimeError]? = nil) {
        self.stops = stops
        self.error = error
    }
}

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=RequestResponseOfStopRequestResponse
public typealias RequestResponseOfStopRequestResponse = BustimeResponse<StopRequestResponse>

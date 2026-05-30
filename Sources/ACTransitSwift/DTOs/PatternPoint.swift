import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=Point
public struct PatternPoint: Codable, Sendable {
    /// Position of this point in the overall sequence of points.
    public let seq: Int
    /// Indicates whether the point is a stop ('S') or waypoint ('W').
    public let typ: String
    /// Unique identifier of the stop. Only present when `typ` is 'S'.
    public let stpid: String?
    /// Display name assigned to the stop. Only present when `typ` is 'S'.
    public let stpnm: String?
    /// Linear distance of this point (feet) into the requested pattern.
    public let pdist: Double
    /// Latitude position of the point in decimal degrees (WGS 84).
    public let lat: Double
    /// Longitude position of the point in decimal degrees (WGS 84).
    public let lon: Double

    public init(seq: Int, typ: String, stpid: String? = nil, stpnm: String? = nil, pdist: Double, lat: Double, lon: Double) {
        self.seq = seq
        self.typ = typ
        self.stpid = stpid
        self.stpnm = stpnm
        self.pdist = pdist
        self.lat = lat
        self.lon = lon
    }

    // MARK: - Mock Data

    public static let sample = PatternPoint(
        seq: 1,
        typ: "S",
        stpid: "55123",
        stpnm: "Telegraph Ave & Ashby Ave",
        pdist: 0,
        lat: 37.8558,
        lon: -122.2597
    )

    public static func make(
        seq: Int = sample.seq,
        typ: String = sample.typ,
        stpid: String? = sample.stpid,
        stpnm: String? = sample.stpnm,
        pdist: Double = sample.pdist,
        lat: Double = sample.lat,
        lon: Double = sample.lon
    ) -> PatternPoint {
        PatternPoint(seq: seq, typ: typ, stpid: stpid, stpnm: stpnm, pdist: pdist, lat: lat, lon: lon)
    }
}

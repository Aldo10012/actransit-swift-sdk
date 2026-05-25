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

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=Pattern
public struct Pattern: Codable, Sendable {
    /// ID of pattern.
    public let pid: Int
    /// Length of the pattern in feet.
    public let ln: Double
    /// Direction valid for this pattern (e.g., "East Bound").
    public let rtdir: String
    /// Geo-positional points (including stops) that define this pattern.
    public let pt: [PatternPoint]
    /// Detour ID if this pattern was created by a detour; omitted for normal patterns.
    public let dtrid: String?
    /// Original pattern points when this pattern was created by a detour.
    public let dtrpt: [PatternPoint]?

    public init(pid: Int, ln: Double, rtdir: String, pt: [PatternPoint], dtrid: String? = nil, dtrpt: [PatternPoint]? = nil) {
        self.pid = pid
        self.ln = ln
        self.rtdir = rtdir
        self.pt = pt
        self.dtrid = dtrid
        self.dtrpt = dtrpt
    }

    // MARK: - Mock Data

    public static let sample = Pattern(
        pid: 12345,
        ln: 52800,
        rtdir: "TO DOWNTOWN BERKELEY",
        pt: [PatternPoint.sample]
    )

    public static let minimal = Pattern(pid: 0, ln: 0, rtdir: "", pt: [])

    public static func make(
        pid: Int = sample.pid,
        ln: Double = sample.ln,
        rtdir: String = sample.rtdir,
        pt: [PatternPoint] = sample.pt,
        dtrid: String? = sample.dtrid,
        dtrpt: [PatternPoint]? = sample.dtrpt
    ) -> Pattern {
        Pattern(pid: pid, ln: ln, rtdir: rtdir, pt: pt, dtrid: dtrid, dtrpt: dtrpt)
    }
}

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=PatternRequestResponse
public struct PatternRequestResponse: Codable, Sendable {
    /// Patterns defining route layouts.
    public let ptr: [Pattern]
    /// Errors from request processing.
    public let error: [BusTimeError]?

    public init(ptr: [Pattern], error: [BusTimeError]? = nil) {
        self.ptr = ptr
        self.error = error
    }
}

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=RequestResponseOfPatternRequestResponse
public typealias RequestResponseOfPatternRequestResponse = BustimeResponse<PatternRequestResponse>

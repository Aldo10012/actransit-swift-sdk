import Foundation

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

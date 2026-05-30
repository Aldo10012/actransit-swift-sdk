import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=Bulletin
public struct Bulletin: Codable, Sendable {
    /// Unique name/identifier of the service bulletin.
    public let nm: String
    /// Service bulletin subject. A short title.
    public let sbj: String
    /// Full text of the service bulletin.
    public let dtl: String
    /// A short text alternative to the service bulletin detail.
    public let brf: String
    /// Reason causing the service bulletin.
    public let cse: String
    /// Impact of the service bulletin.
    public let efct: String
    /// Priority level (High, Medium, Low).
    public let prty: String
    /// (Multi-feed only) The name of the data feed.
    public let rtpidatafeed: String?
    /// Routes, directions, and stops affected. Empty if applies to all.
    public let srvc: [ServiceBulletin]
    /// Last service bulletin modification in local time zone.
    public let mod: String

    public init(
        nm: String,
        sbj: String,
        dtl: String,
        brf: String,
        cse: String,
        efct: String,
        prty: String,
        rtpidatafeed: String? = nil,
        srvc: [ServiceBulletin],
        mod: String
    ) {
        self.nm = nm
        self.sbj = sbj
        self.dtl = dtl
        self.brf = brf
        self.cse = cse
        self.efct = efct
        self.prty = prty
        self.rtpidatafeed = rtpidatafeed
        self.srvc = srvc
        self.mod = mod
    }

    // MARK: - Mock Data

    public static let sample = Bulletin(
        nm: "SB-2023-001",
        sbj: "Route 51A Detour",
        dtl: "Route 51A is detouring around Telegraph Ave due to construction.",
        brf: "51A detour in effect.",
        cse: "Construction",
        efct: "Delays of up to 10 minutes",
        prty: "Medium",
        srvc: [ServiceBulletin.sample],
        mod: "20230615 08:00:00"
    )

    public static let minimal = Bulletin(nm: "", sbj: "", dtl: "", brf: "", cse: "", efct: "", prty: "", srvc: [], mod: "")

    public static func make(
        nm: String = sample.nm,
        sbj: String = sample.sbj,
        dtl: String = sample.dtl,
        brf: String = sample.brf,
        cse: String = sample.cse,
        efct: String = sample.efct,
        prty: String = sample.prty,
        rtpidatafeed: String? = sample.rtpidatafeed,
        srvc: [ServiceBulletin] = sample.srvc,
        mod: String = sample.mod
    ) -> Bulletin {
        Bulletin(nm: nm, sbj: sbj, dtl: dtl, brf: brf, cse: cse, efct: efct, prty: prty, rtpidatafeed: rtpidatafeed, srvc: srvc, mod: mod)
    }
}

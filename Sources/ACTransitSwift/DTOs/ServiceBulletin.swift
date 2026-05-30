import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=ServiceBulletin
public struct ServiceBulletin: Codable, Sendable {
    /// Alphanumeric designator of the affected route.
    public let rt: String?
    /// Direction of the affected route.
    public let rtdir: String?
    /// Identifier of the affected stop.
    public let stpid: String?
    /// Name of the affected stop.
    public let stpnm: String?

    public init(rt: String? = nil, rtdir: String? = nil, stpid: String? = nil, stpnm: String? = nil) {
        self.rt = rt
        self.rtdir = rtdir
        self.stpid = stpid
        self.stpnm = stpnm
    }

    // MARK: - Mock Data

    public static let sample = ServiceBulletin(rt: "51A", rtdir: "TO DOWNTOWN BERKELEY", stpid: "55123", stpnm: "Telegraph Ave & Ashby Ave")

    public static func make(
        rt: String? = sample.rt,
        rtdir: String? = sample.rtdir,
        stpid: String? = sample.stpid,
        stpnm: String? = sample.stpnm
    ) -> ServiceBulletin {
        ServiceBulletin(rt: rt, rtdir: rtdir, stpid: stpid, stpnm: stpnm)
    }
}

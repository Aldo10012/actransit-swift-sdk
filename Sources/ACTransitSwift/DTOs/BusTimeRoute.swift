import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=Route
public struct BusTimeRoute: Codable, Sendable {
    /// Alphanumeric designator of a route (e.g., "20" or "X20").
    public let rt: String
    /// Common name of the route (e.g., "Madison" for the 20 route).
    public let rtnm: String
    /// Color of the route line used in map (e.g., "#ffffff").
    public let rtclr: String
    /// Language-specific route designator meant for display.
    public let rtdd: String
    /// (Multi-feed only) The identifier of the data feed.
    public let rtpidatafeed: String?

    public init(rt: String, rtnm: String, rtclr: String, rtdd: String, rtpidatafeed: String? = nil) {
        self.rt = rt
        self.rtnm = rtnm
        self.rtclr = rtclr
        self.rtdd = rtdd
        self.rtpidatafeed = rtpidatafeed
    }

    // MARK: - Mock Data

    public static let sample = BusTimeRoute(
        rt: "51A",
        rtnm: "Telegraph Ave",
        rtclr: "#3366cc",
        rtdd: "51A",
        rtpidatafeed: "AC_TRANSIT_BT"
    )

    public static func make(
        rt: String = sample.rt,
        rtnm: String = sample.rtnm,
        rtclr: String = sample.rtclr,
        rtdd: String = sample.rtdd,
        rtpidatafeed: String? = sample.rtpidatafeed
    ) -> BusTimeRoute {
        BusTimeRoute(rt: rt, rtnm: rtnm, rtclr: rtclr, rtdd: rtdd, rtpidatafeed: rtpidatafeed)
    }
}

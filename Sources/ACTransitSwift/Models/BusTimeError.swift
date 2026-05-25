import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=BusTimeError
public struct BusTimeError: Codable, Sendable {
    /// (Multi-feed only) The identifier of the data feed. Omitted if not a multi-feed system.
    public let rtpidatafeed: String?
    /// The ID of a stop that was referenced in the request.
    public let stpid: String?
    /// The route that was referenced in the request.
    public let rt: String?
    /// The ID of a vehicle that was referenced in the request.
    public let vid: String?
    /// A message that describes the error.
    public let msg: String

    public init(
        rtpidatafeed: String? = nil,
        stpid: String? = nil,
        rt: String? = nil,
        vid: String? = nil,
        msg: String
    ) {
        self.rtpidatafeed = rtpidatafeed
        self.stpid = stpid
        self.rt = rt
        self.vid = vid
        self.msg = msg
    }

    // MARK: - Mock Data

    public static let sample = BusTimeError(msg: "No data found for parameter")

    public static func make(
        rtpidatafeed: String? = sample.rtpidatafeed,
        stpid: String? = sample.stpid,
        rt: String? = sample.rt,
        vid: String? = sample.vid,
        msg: String = sample.msg
    ) -> BusTimeError {
        BusTimeError(rtpidatafeed: rtpidatafeed, stpid: stpid, rt: rt, vid: vid, msg: msg)
    }
}

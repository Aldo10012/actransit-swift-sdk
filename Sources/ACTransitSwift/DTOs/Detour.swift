import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=Detour
public struct Detour: Codable, Sendable {
    /// The unique id of the detour. Other API calls reference these identifiers.
    public let id: String
    /// The version of this detour. Only the newest version of each detour is returned.
    public let ver: String
    /// The state of the detour. A value of 1 indicates the detour is active; 0 indicates a canceled detour.
    public let st: String
    /// Description of the detour.
    public let desc: String
    /// Affected route/direction pairs.
    public let rtdirs: [RtDir]
    /// The start date and time of this detour.
    public let startdt: String
    /// The end date and time of this detour.
    public let enddt: String

    public init(
        id: String,
        ver: String,
        st: String,
        desc: String,
        rtdirs: [RtDir],
        startdt: String,
        enddt: String
    ) {
        self.id = id
        self.ver = ver
        self.st = st
        self.desc = desc
        self.rtdirs = rtdirs
        self.startdt = startdt
        self.enddt = enddt
    }

    // MARK: - Mock Data

    public static let sample = Detour(
        id: "1234",
        ver: "1",
        st: "1",
        desc: "Route 51A detour near Telegraph Ave due to road closure.",
        rtdirs: [RtDir.sample],
        startdt: "20230615 08:00",
        enddt: "20230615 20:00"
    )

    public static let minimal = Detour(
        id: "",
        ver: "",
        st: "",
        desc: "",
        rtdirs: [],
        startdt: "",
        enddt: ""
    )

    public static func make(
        id: String = sample.id,
        ver: String = sample.ver,
        st: String = sample.st,
        desc: String = sample.desc,
        rtdirs: [RtDir] = sample.rtdirs,
        startdt: String = sample.startdt,
        enddt: String = sample.enddt
    ) -> Detour {
        Detour(id: id, ver: ver, st: st, desc: desc, rtdirs: rtdirs, startdt: startdt, enddt: enddt)
    }
}

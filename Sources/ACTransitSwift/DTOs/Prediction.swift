import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=Prediction
public struct Prediction: Codable, Sendable {
    /// Date and time of the last positional update of the vehicle.
    public let tmstmp: String
    /// Type of prediction: `A` for arrival, `D` for departure.
    public let typ: String
    /// Display name of the stop for which this prediction was generated.
    public let stpnm: String
    /// Unique identifier representing the stop for which this prediction was generated.
    public let stpid: String
    /// Unique ID of the vehicle for which this prediction was generated.
    public let vid: String
    /// Linear distance (feet) of the vehicle from the stop.
    public let dstp: Int
    /// Alphanumeric designator of the route served by the vehicle.
    public let rt: String
    /// Language-specific route designator meant for display.
    public let rtdd: String?
    /// Direction of travel of the route associated with this prediction.
    public let rtdir: String
    /// Final destination of the vehicle.
    public let des: String
    /// Predicted date and time of the vehicle's arrival or departure.
    public let prdtm: String
    /// TA's block identifier for the scheduled trip the vehicle is currently serving.
    public let tablockid: String?
    /// TA's trip identifier for the scheduled trip the vehicle is currently serving.
    public let tatripid: String?
    /// TA's unique trip identifier for the scheduled trip the vehicle is currently serving.
    public let origtatripno: String?
    /// Whether the vehicle is delayed.
    public let dly: Bool
    /// A value of `true` indicates that real-time data for the vehicle is available.
    public let dyn: Int?
    /// Minutes remaining until the vehicle reaches the stop. May be `DUE` when imminent.
    public let prdctdn: String
    /// Zone identifier.
    public let zone: String?
    /// Alphanumeric string defining the run identifier.
    public let rid: String?
    /// Unique ID for the current trip of the vehicle.
    public let tripid: String?
    /// A value indicating the dynamic trip type.
    public let tripdyn: Int?
    /// Scheduled date and time of the vehicle's arrival or departure.
    public let schdtm: String?
    /// Geofence identifier.
    public let geoid: String?
    /// Position in the sequence of stops on the current trip.
    public let seq: Int
    /// Passenger load of the vehicle.
    public let psgld: String?
    /// Number of stops remaining before the vehicle reaches the predicted stop.
    public let stst: Int?
    /// Distance (feet) remaining before the vehicle reaches the predicted stop.
    public let stsd: String?
    /// Whether the stop is a flag stop (1) or not (0).
    public let flagstop: Int?

    public init(
        tmstmp: String,
        typ: String,
        stpnm: String,
        stpid: String,
        vid: String,
        dstp: Int,
        rt: String,
        rtdd: String? = nil,
        rtdir: String,
        des: String,
        prdtm: String,
        tablockid: String? = nil,
        tatripid: String? = nil,
        origtatripno: String? = nil,
        dly: Bool,
        dyn: Int? = nil,
        prdctdn: String,
        zone: String? = nil,
        rid: String? = nil,
        tripid: String? = nil,
        tripdyn: Int? = nil,
        schdtm: String? = nil,
        geoid: String? = nil,
        seq: Int,
        psgld: String? = nil,
        stst: Int? = nil,
        stsd: String? = nil,
        flagstop: Int? = nil
    ) {
        self.tmstmp = tmstmp
        self.typ = typ
        self.stpnm = stpnm
        self.stpid = stpid
        self.vid = vid
        self.dstp = dstp
        self.rt = rt
        self.rtdd = rtdd
        self.rtdir = rtdir
        self.des = des
        self.prdtm = prdtm
        self.tablockid = tablockid
        self.tatripid = tatripid
        self.origtatripno = origtatripno
        self.dly = dly
        self.dyn = dyn
        self.prdctdn = prdctdn
        self.zone = zone
        self.rid = rid
        self.tripid = tripid
        self.tripdyn = tripdyn
        self.schdtm = schdtm
        self.geoid = geoid
        self.seq = seq
        self.psgld = psgld
        self.stst = stst
        self.stsd = stsd
        self.flagstop = flagstop
    }

    // MARK: - Mock Data

    public static let sample = Prediction(
        tmstmp: "20230615 14:25",
        typ: "A",
        stpnm: "Telegraph Ave & Ashby Ave",
        stpid: "55123",
        vid: "5016",
        dstp: 1200,
        rt: "51A",
        rtdir: "TO DOWNTOWN BERKELEY",
        des: "Downtown Berkeley",
        prdtm: "20230615 14:30",
        dly: false,
        prdctdn: "5",
        seq: 3
    )

    public static func make(
        tmstmp: String = sample.tmstmp,
        typ: String = sample.typ,
        stpnm: String = sample.stpnm,
        stpid: String = sample.stpid,
        vid: String = sample.vid,
        dstp: Int = sample.dstp,
        rt: String = sample.rt,
        rtdd: String? = sample.rtdd,
        rtdir: String = sample.rtdir,
        des: String = sample.des,
        prdtm: String = sample.prdtm,
        tablockid: String? = sample.tablockid,
        tatripid: String? = sample.tatripid,
        origtatripno: String? = sample.origtatripno,
        dly: Bool = sample.dly,
        dyn: Int? = sample.dyn,
        prdctdn: String = sample.prdctdn,
        zone: String? = sample.zone,
        rid: String? = sample.rid,
        tripid: String? = sample.tripid,
        tripdyn: Int? = sample.tripdyn,
        schdtm: String? = sample.schdtm,
        geoid: String? = sample.geoid,
        seq: Int = sample.seq,
        psgld: String? = sample.psgld,
        stst: Int? = sample.stst,
        stsd: String? = sample.stsd,
        flagstop: Int? = sample.flagstop
    ) -> Prediction {
        Prediction(
            tmstmp: tmstmp, typ: typ, stpnm: stpnm, stpid: stpid, vid: vid, dstp: dstp,
            rt: rt, rtdd: rtdd, rtdir: rtdir, des: des, prdtm: prdtm, tablockid: tablockid,
            tatripid: tatripid, origtatripno: origtatripno, dly: dly, dyn: dyn,
            prdctdn: prdctdn, zone: zone, rid: rid, tripid: tripid, tripdyn: tripdyn,
            schdtm: schdtm, geoid: geoid, seq: seq, psgld: psgld, stst: stst, stsd: stsd, flagstop: flagstop
        )
    }
}

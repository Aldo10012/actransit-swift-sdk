import Foundation

/// https://api.actransit.org/transit/Help/Api/GET-actrealtime-vehicle_vid_rt_tmres_callback_lat_lng_searchRadius
public struct BusTimeVehicle: Codable, Sendable {
    /// Unique identifier for the vehicle.
    public let vid: String
    /// Date and time of the last positional update of the vehicle.
    public let tmstmp: String
    /// Latitude position of the vehicle in decimal degrees (WGS 84).
    public let lat: String
    /// Longitude position of the vehicle in decimal degrees (WGS 84).
    public let lon: String
    /// Heading direction of the vehicle in degrees (0–359).
    public let hdg: String
    /// Pattern ID of the trip currently being executed.
    public let pid: Int
    /// Linear distance (feet) of the vehicle into the pattern.
    public let pdist: Int
    /// Alphanumeric designator of the route served by the vehicle.
    public let rt: String
    /// Language-specific route designator meant for display.
    public let rtdd: String?
    /// Final destination of the vehicle.
    public let des: String
    /// Whether the vehicle is delayed.
    public let dly: Bool
    /// TA's block identifier for the scheduled trip the vehicle is currently serving.
    public let tablockid: String?
    /// TA's trip identifier for the scheduled trip the vehicle is currently serving.
    public let tatripid: String?
    /// TA's unique trip identifier for the scheduled trip the vehicle is currently serving.
    public let origtatripno: String?
    /// Zone identifier.
    public let zone: String?
    /// Mode of transportation (0 = bus).
    public let mode: Int?
    /// Passenger load of the vehicle.
    public let psgld: String?
    /// Number of stops remaining before the vehicle reaches the predicted stop.
    public let stst: Int?
    /// Distance (feet) remaining before the vehicle reaches the predicted stop.
    public let stsd: String?
    /// Route PID data feed identifier.
    public let rtpidatafeed: String?
    /// Time resolution used: `M` for minutes, `S` for seconds.
    public let tmres: String?
    /// A value indicating the dynamic trip type.
    public let dyn: Int?
    /// Unique ID for the current trip of the vehicle.
    public let tripid: String?
    /// A value indicating the dynamic trip type for the vehicle's trip.
    public let tripdyn: Int?

    public init(
        vid: String,
        tmstmp: String,
        lat: String,
        lon: String,
        hdg: String,
        pid: Int,
        pdist: Int,
        rt: String,
        rtdd: String? = nil,
        des: String,
        dly: Bool,
        tablockid: String? = nil,
        tatripid: String? = nil,
        origtatripno: String? = nil,
        zone: String? = nil,
        mode: Int? = nil,
        psgld: String? = nil,
        stst: Int? = nil,
        stsd: String? = nil,
        rtpidatafeed: String? = nil,
        tmres: String? = nil,
        dyn: Int? = nil,
        tripid: String? = nil,
        tripdyn: Int? = nil
    ) {
        self.vid = vid
        self.tmstmp = tmstmp
        self.lat = lat
        self.lon = lon
        self.hdg = hdg
        self.pid = pid
        self.pdist = pdist
        self.rt = rt
        self.rtdd = rtdd
        self.des = des
        self.dly = dly
        self.tablockid = tablockid
        self.tatripid = tatripid
        self.origtatripno = origtatripno
        self.zone = zone
        self.mode = mode
        self.psgld = psgld
        self.stst = stst
        self.stsd = stsd
        self.rtpidatafeed = rtpidatafeed
        self.tmres = tmres
        self.dyn = dyn
        self.tripid = tripid
        self.tripdyn = tripdyn
    }

    // MARK: - Mock Data

    public static let sample = BusTimeVehicle(
        vid: "5016",
        tmstmp: "20230615 14:25",
        lat: "37.855800",
        lon: "-122.259700",
        hdg: "180",
        pid: 12345,
        pdist: 1200,
        rt: "51A",
        des: "Downtown Berkeley BART Station",
        dly: false,
        rtpidatafeed: "AC_TRANSIT_BT",
        tmres: "M"
    )

    public static func make(
        vid: String = sample.vid,
        tmstmp: String = sample.tmstmp,
        lat: String = sample.lat,
        lon: String = sample.lon,
        hdg: String = sample.hdg,
        pid: Int = sample.pid,
        pdist: Int = sample.pdist,
        rt: String = sample.rt,
        rtdd: String? = sample.rtdd,
        des: String = sample.des,
        dly: Bool = sample.dly,
        tablockid: String? = sample.tablockid,
        tatripid: String? = sample.tatripid,
        origtatripno: String? = sample.origtatripno,
        zone: String? = sample.zone,
        mode: Int? = sample.mode,
        psgld: String? = sample.psgld,
        stst: Int? = sample.stst,
        stsd: String? = sample.stsd,
        rtpidatafeed: String? = sample.rtpidatafeed,
        tmres: String? = sample.tmres,
        dyn: Int? = sample.dyn,
        tripid: String? = sample.tripid,
        tripdyn: Int? = sample.tripdyn
    ) -> BusTimeVehicle {
        BusTimeVehicle(
            vid: vid, tmstmp: tmstmp, lat: lat, lon: lon, hdg: hdg,
            pid: pid, pdist: pdist, rt: rt, rtdd: rtdd, des: des, dly: dly,
            tablockid: tablockid, tatripid: tatripid, origtatripno: origtatripno,
            zone: zone, mode: mode, psgld: psgld, stst: stst, stsd: stsd,
            rtpidatafeed: rtpidatafeed, tmres: tmres, dyn: dyn, tripid: tripid, tripdyn: tripdyn
        )
    }
}

/// https://api.actransit.org/transit/Help/Api/GET-actrealtime-vehicle_vid_rt_tmres_callback_lat_lng_searchRadius
public struct VehicleRequestResponse: Codable, Sendable {
    /// Vehicles matching the request.
    public let vehicle: [BusTimeVehicle]
    /// Errors from request processing.
    public let error: [BusTimeError]?

    public init(vehicle: [BusTimeVehicle], error: [BusTimeError]? = nil) {
        self.vehicle = vehicle
        self.error = error
    }
}

/// https://api.actransit.org/transit/Help/Api/GET-actrealtime-vehicle_vid_rt_tmres_callback_lat_lng_searchRadius
public typealias RequestResponseOfVehicleRequestResponse = BustimeResponse<VehicleRequestResponse>

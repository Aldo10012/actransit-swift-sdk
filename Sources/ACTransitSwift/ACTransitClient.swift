import EZNetworking
import Foundation

public class ACTransitClient {
    /// GTFS schedule endpoints.
    public let gtfs: GTFSService
    /// Trip cancellation endpoints.
    public let trips: TripsService
    /// Route listing, schedule, and stop endpoints.
    public let routes: RoutesService
    /// Stop lookup and proximity search endpoints.
    public let stops: StopsService
    /// Vehicle location, characteristics, and real-time occupancy endpoints.
    public let vehicles: VehicleService
    /// BusTime® real-time endpoints.
    public let actRealtime: ActRealtimeService

    public convenience init() {
        self.init(token: ACTransitPlugins.apiToken, performer: RequestPerformer())
    }

    init(token: String, performer: RequestPerformable) {
        gtfs = GTFSService(token: token, performer: performer)
        trips = TripsService(token: token, performer: performer)
        routes = RoutesService(token: token, performer: performer)
        stops = StopsService(token: token, performer: performer)
        vehicles = VehicleService(token: token, performer: performer)
        actRealtime = ActRealtimeService(token: token, performer: performer)
    }
}

import EZNetworking
import Foundation

public class ACTransitClient {
    /// GTFS schedule endpoints.
    public let gtfs: GTFSService
    /// Trip cancellation endpoints.
    public let trips: TripsService

    public convenience init() {
        self.init(token: ACTransitPlugins.apiToken, performer: RequestPerformer())
    }

    init(token: String, performer: RequestPerformable) {
        gtfs = GTFSService(token: token, performer: performer)
        trips = TripsService(token: token, performer: performer)
    }
}

import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=TripEstimate
public struct TripEstimate: Codable, Sendable {
    public let routeName: String
    /// The starting point Stop Id.
    public let originStopId: Int
    /// The destination Stop Id.
    public let destinationStopId: Int
    /// The predicted time a vehicle should arrive at the OriginStopId.
    public let expectedDepartureTime: String
    /// Total trip time.
    public let tripDuration: String
    /// The vehicle id which is expected to service the trip.
    public let vehicleId: Int?

    public init(routeName: String, originStopId: Int, destinationStopId: Int, expectedDepartureTime: String, tripDuration: String, vehicleId: Int?) {
        self.routeName = routeName
        self.originStopId = originStopId
        self.destinationStopId = destinationStopId
        self.expectedDepartureTime = expectedDepartureTime
        self.tripDuration = tripDuration
        self.vehicleId = vehicleId
    }

    enum CodingKeys: String, CodingKey {
        case routeName = "RouteName"
        case originStopId = "OriginStopId"
        case destinationStopId = "DestinationStopId"
        case expectedDepartureTime = "ExpectedDepartureTime"
        case tripDuration = "TripDuration"
        case vehicleId = "VehicleId"
    }

    // MARK: - Mock Data

    public static let sample = TripEstimate(
        routeName: "72",
        originStopId: 55888,
        destinationStopId: 51632,
        expectedDepartureTime: "2026-05-23T21:35:00",
        tripDuration: "01:05:00",
        vehicleId: nil
    )

    public static let minimal = TripEstimate(
        routeName: "72",
        originStopId: 55888,
        destinationStopId: 51632,
        expectedDepartureTime: "2026-05-23T21:35:00",
        tripDuration: "01:05:00",
        vehicleId: nil
    )

    public static func make(
        routeName: String = sample.routeName,
        originStopId: Int = sample.originStopId,
        destinationStopId: Int = sample.destinationStopId,
        expectedDepartureTime: String = sample.expectedDepartureTime,
        tripDuration: String = sample.tripDuration,
        vehicleId: Int? = sample.vehicleId
    ) -> TripEstimate {
        TripEstimate(routeName: routeName, originStopId: originStopId, destinationStopId: destinationStopId, expectedDepartureTime: expectedDepartureTime, tripDuration: tripDuration, vehicleId: vehicleId)
    }
}

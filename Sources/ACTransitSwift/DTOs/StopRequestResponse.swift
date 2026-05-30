import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=StopRequestResponse
public struct StopRequestResponse: Codable, Sendable {
    /// Stops matching the request.
    public let stops: [BusTimeStop]
    /// Errors from request processing.
    public let error: [BusTimeError]?

    public init(stops: [BusTimeStop], error: [BusTimeError]? = nil) {
        self.stops = stops
        self.error = error
    }
}

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=RequestResponseOfStopRequestResponse
public typealias RequestResponseOfStopRequestResponse = BusTimeResponse<StopRequestResponse>

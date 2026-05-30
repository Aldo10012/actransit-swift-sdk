import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=DirectionRequestResponse
public struct DirectionRequestResponse: Codable, Sendable {
    /// Directions serviced by the requested route.
    public let directions: [ActRealtimeDirection]
    /// Errors from request processing.
    public let error: [BusTimeError]?

    public init(directions: [ActRealtimeDirection], error: [BusTimeError]? = nil) {
        self.directions = directions
        self.error = error
    }
}

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=RequestResponseOfDirectionRequestResponse
public typealias RequestResponseOfDirectionRequestResponse = BusTimeResponse<DirectionRequestResponse>

import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=DetourRequestResponse
public struct DetourRequestResponse: Codable, Sendable {
    /// Active detours.
    public let dtrs: [Detour]
    /// Errors from request processing.
    public let error: [BusTimeError]?

    public init(dtrs: [Detour], error: [BusTimeError]? = nil) {
        self.dtrs = dtrs
        self.error = error
    }
}

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=RequestResponseOfDetourRequestResponse
public typealias RequestResponseOfDetourRequestResponse = BusTimeResponse<DetourRequestResponse>

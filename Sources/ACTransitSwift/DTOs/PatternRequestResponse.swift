import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=PatternRequestResponse
public struct PatternRequestResponse: Codable, Sendable {
    /// Patterns defining route layouts.
    public let ptr: [Pattern]
    /// Errors from request processing.
    public let error: [BusTimeError]?

    public init(ptr: [Pattern], error: [BusTimeError]? = nil) {
        self.ptr = ptr
        self.error = error
    }
}

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=RequestResponseOfPatternRequestResponse
public typealias RequestResponseOfPatternRequestResponse = BusTimeResponse<PatternRequestResponse>

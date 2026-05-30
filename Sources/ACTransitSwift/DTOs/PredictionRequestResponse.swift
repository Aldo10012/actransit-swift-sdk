import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=PredictionRequestResponse
public struct PredictionRequestResponse: Codable, Sendable {
    /// Predicted arrival or departure times.
    public let prd: [Prediction]
    /// Errors from request processing.
    public let error: [BusTimeError]?

    public init(prd: [Prediction], error: [BusTimeError]? = nil) {
        self.prd = prd
        self.error = error
    }
}

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=RequestResponseOfPredictionRequestResponse
public typealias RequestResponseOfPredictionRequestResponse = BusTimeResponse<PredictionRequestResponse>

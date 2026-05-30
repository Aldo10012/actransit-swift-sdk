@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test PredictionRequestResponse")
final class PredictionRequestResponseTests {
    @Test("init stores predictions and error")
    func initStoresPredictions() {
        let prediction = Prediction.sample
        let response = PredictionRequestResponse(prd: [prediction], error: nil)
        #expect(response.prd.count == 1)
        #expect(response.prd[0].vid == prediction.vid)
        #expect(response.error == nil)
    }
}

@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test Prediction")
final class PredictionTests {
    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = Prediction.make(vid: "9999")
        #expect(result.vid == "9999")
        #expect(result.tmstmp == Prediction.sample.tmstmp)
        #expect(result.typ == Prediction.sample.typ)
        #expect(result.stpid == Prediction.sample.stpid)
        #expect(result.dstp == Prediction.sample.dstp)
        #expect(result.rt == Prediction.sample.rt)
        #expect(result.prdctdn == Prediction.sample.prdctdn)
        #expect(result.dly == Prediction.sample.dly)
        #expect(result.seq == Prediction.sample.seq)
    }

    @Test("PredictionRequestResponse init stores predictions and error")
    func predictionRequestResponseInit() {
        let prediction = Prediction.sample
        let response = PredictionRequestResponse(prd: [prediction], error: nil)
        #expect(response.prd.count == 1)
        #expect(response.prd[0].vid == prediction.vid)
        #expect(response.error == nil)
    }
}

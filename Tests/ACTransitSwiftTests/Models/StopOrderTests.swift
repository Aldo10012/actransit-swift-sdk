@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test StopOrder")
final class StopOrderTests {
    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = StopOrder.make(stopId: 99999)
        #expect(result.stopId == 99999)
        #expect(result.name == StopOrder.sample.name)
        #expect(result.latitude == StopOrder.sample.latitude)
        #expect(result.longitude == StopOrder.sample.longitude)
        #expect(result.order == StopOrder.sample.order)
    }
}

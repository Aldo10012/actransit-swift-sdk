@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test ActRealtimeDirection")
final class ActRealtimeDirectionTests {
    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = ActRealtimeDirection.make(id: "TO RICHMOND")
        #expect(result.id == "TO RICHMOND")
        #expect(result.name == ActRealtimeDirection.sample.name)
    }

    @Test("DirectionRequestResponse init stores directions and error")
    func directionRequestResponseInit() {
        let direction = ActRealtimeDirection.sample
        let response = DirectionRequestResponse(directions: [direction], error: nil)
        #expect(response.directions.count == 1)
        #expect(response.directions[0].id == direction.id)
        #expect(response.error == nil)
    }
}

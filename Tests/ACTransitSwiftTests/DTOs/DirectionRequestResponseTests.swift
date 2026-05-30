@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test DirectionRequestResponse")
final class DirectionRequestResponseTests {
    @Test("init stores directions and error")
    func initStoresDirections() {
        let direction = ActRealtimeDirection.sample
        let response = DirectionRequestResponse(directions: [direction], error: nil)
        #expect(response.directions.count == 1)
        #expect(response.directions[0].id == direction.id)
        #expect(response.error == nil)
    }
}

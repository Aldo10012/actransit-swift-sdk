@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test StopRouteDestination")
final class StopRouteDestinationTests {
    @Test("decodes from JSON")
    func decodesFromJSON() throws {
        let json = """
        {
            "RouteId": "72",
            "DirectionId": 0,
            "Direction": "Southbound",
            "Destination": "Jack London Square",
            "FinalPassingTime": "2026-05-24T23:45:00",
            "Status": "Active"
        }
        """
        let result = try JSONDecoder().decode(StopRouteDestination.self, from: Data(json.utf8))
        #expect(result.routeId == "72")
        #expect(result.directionId == 0)
        #expect(result.direction == "Southbound")
        #expect(result.destination == "Jack London Square")
        #expect(result.finalPassingTime == "2026-05-24T23:45:00")
        #expect(result.status == "Active")
    }

    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = StopRouteDestination.make(routeId: "51A")
        #expect(result.routeId == "51A")
        #expect(result.directionId == StopRouteDestination.sample.directionId)
        #expect(result.direction == StopRouteDestination.sample.direction)
        #expect(result.destination == StopRouteDestination.sample.destination)
        #expect(result.finalPassingTime == StopRouteDestination.sample.finalPassingTime)
        #expect(result.status == StopRouteDestination.sample.status)
    }
}

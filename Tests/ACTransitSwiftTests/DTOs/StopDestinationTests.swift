@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test StopDestination")
final class StopDestinationTests {
    @Test("decodes from JSON")
    func decodesFromJSON() throws {
        let json = """
        {
            "StopId": 55888,
            "Status": "Active",
            "RouteDestinations": [
                {
                    "RouteId": "72",
                    "DirectionId": 0,
                    "Direction": "Southbound",
                    "Destination": "Jack London Square",
                    "FinalPassingTime": "2026-05-24T23:45:00",
                    "Status": "Active"
                }
            ]
        }
        """
        let result = try JSONDecoder().decode(StopDestination.self, from: Data(json.utf8))
        #expect(result.stopId == 55888)
        #expect(result.status == "Active")
        #expect(result.routeDestinations.count == 1)
        #expect(result.routeDestinations[0].routeId == "72")
    }

    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = StopDestination.make(stopId: 99999)
        #expect(result.stopId == 99999)
        #expect(result.status == StopDestination.sample.status)
        #expect(result.routeDestinations.count == StopDestination.sample.routeDestinations.count)
    }
}

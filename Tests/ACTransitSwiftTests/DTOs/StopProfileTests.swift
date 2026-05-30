@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test StopProfile")
final class StopProfileTests {
    @Test("decodes from JSON")
    func decodesFromJSON() throws {
        let json = """
        {
            "StopId": 55888,
            "Street": "Giant Rd",
            "City": "Richmond",
            "SiteDirection": "NW corner",
            "Site": "Giant Rd at Castro St",
            "Corner": "NW",
            "IsInService": true,
            "Latitude": 37.9710794,
            "Longitude": -122.3398753,
            "Routes": "72,72R",
            "AllowAlighting": true,
            "AllowBoarding": true,
            "PlaceId": "CCCO",
            "PlaceDescription": "Contra Costa College",
            "StopServiceAlerts": { "Url": "https://511.org/transit/alerts/55888" },
            "Amenities": { "Url": "https://511.org/transit/amenities/55888" },
            "Predictions": { "Url": "https://511.org/transit/real-time-arrivals?stopId=55888" },
            "Map": { "Url": "https://511.org/transit/stops/map/55888" },
            "Schedules": [
                { "RouteId": "72", "Url": "https://511.org/transit/schedules/72" }
            ]
        }
        """
        let result = try JSONDecoder().decode(StopProfile.self, from: Data(json.utf8))
        #expect(result.stopId == 55888)
        #expect(result.city == "Richmond")
        #expect(result.routes == "72,72R")
        #expect(result.isInService == true)
        #expect(result.schedules.count == 1)
        #expect(result.schedules[0].routeId == "72")
        #expect(result.stopServiceAlerts?.url == "https://511.org/transit/alerts/55888")
    }

    @Test("decodes with nil optional fields")
    func decodesWithNilOptionalFields() throws {
        let json = """
        {
            "StopId": 55888,
            "IsInService": true,
            "Latitude": 37.9710794,
            "Longitude": -122.3398753,
            "AllowAlighting": true,
            "AllowBoarding": true,
            "Schedules": []
        }
        """
        let result = try JSONDecoder().decode(StopProfile.self, from: Data(json.utf8))
        #expect(result.street == nil)
        #expect(result.city == nil)
        #expect(result.routes == nil)
        #expect(result.stopServiceAlerts == nil)
        #expect(result.schedules.isEmpty)
    }

    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = StopProfile.make(stopId: 99999)
        #expect(result.stopId == 99999)
        #expect(result.city == StopProfile.sample.city)
        #expect(result.isInService == StopProfile.sample.isInService)
        #expect(result.latitude == StopProfile.sample.latitude)
        #expect(result.longitude == StopProfile.sample.longitude)
        #expect(result.routes == StopProfile.sample.routes)
        #expect(result.allowAlighting == StopProfile.sample.allowAlighting)
        #expect(result.allowBoarding == StopProfile.sample.allowBoarding)
        #expect(result.schedules.count == StopProfile.sample.schedules.count)
    }
}

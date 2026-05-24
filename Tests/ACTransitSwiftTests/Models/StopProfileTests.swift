@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test InfoUrl")
final class InfoUrlTests {
    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = InfoUrl.make(url: "https://example.com/custom")
        #expect(result.url == "https://example.com/custom")
    }
}

@Suite("Test RouteUrl")
final class RouteUrlTests {
    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = RouteUrl.make(routeId: "51A")
        #expect(result.routeId == "51A")
        #expect(result.url == RouteUrl.sample.url)
    }
}

@Suite("Test StopProfile")
final class StopProfileTests {
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

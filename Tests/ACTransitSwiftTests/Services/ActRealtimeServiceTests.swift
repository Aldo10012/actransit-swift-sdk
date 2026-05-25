@testable import ACTransitSwift
import EZNetworking
import Foundation
import Testing

@Suite("Test ActRealtimeService")
final class ActRealtimeServiceTests {
    private var sut: ActRealtimeService

    init() {
        sut = ActRealtimeService(token: "mockToken", performer: MockRequestPerformer())
    }

    private func setup(mockJSON: Data?) {
        var performer = MockRequestPerformer()
        performer.fixture = mockJSON
        sut = ActRealtimeService(token: "mockToken", performer: performer)
    }

    // MARK: - Tests

    @Test("test .detour() success case")
    func detour() async throws {
        let jsonString = """
        {
            "bustime-response": {
                "dtrs": [
                    {
                        "id": "1234",
                        "ver": "1",
                        "st": "1",
                        "desc": "Route 51A detour near Telegraph Ave due to road closure.",
                        "rtdirs": [{ "rt": "51A", "dir": "TO DOWNTOWN BERKELEY" }],
                        "startdt": "20230615 08:00",
                        "enddt": "20230615 20:00"
                    }
                ],
                "error": []
            }
        }
        """
        setup(mockJSON: jsonString.data(using: .utf8))

        let result = try await sut.detour()
        #expect(result.dtrs.count == 1)
        #expect(result.dtrs[0].id == Detour.sample.id)
        #expect(result.dtrs[0].ver == Detour.sample.ver)
        #expect(result.dtrs[0].st == Detour.sample.st)
        #expect(result.dtrs[0].desc == Detour.sample.desc)
        #expect(result.dtrs[0].rtdirs.count == 1)
        #expect(result.dtrs[0].rtdirs[0].rt == RtDir.sample.rt)
        #expect(result.dtrs[0].rtdirs[0].dir == RtDir.sample.dir)
        #expect(result.dtrs[0].startdt == Detour.sample.startdt)
        #expect(result.dtrs[0].enddt == Detour.sample.enddt)
    }

    @Test("test .direction() success case")
    func direction() async throws {
        let jsonString = """
        {
            "bustime-response": {
                "directions": [
                    { "id": "TO DOWNTOWN BERKELEY", "name": "TO DOWNTOWN BERKELEY" }
                ],
                "error": []
            }
        }
        """
        setup(mockJSON: jsonString.data(using: .utf8))

        let result = try await sut.direction(route: "51A")
        #expect(result.directions.count == 1)
        #expect(result.directions[0].id == ActRealtimeDirection.sample.id)
        #expect(result.directions[0].name == ActRealtimeDirection.sample.name)
    }

    @Test("test .line() success case")
    func line() async throws {
        let jsonString = """
        {
            "bustime-response": {
                "routes": [
                    {
                        "rt": "51A",
                        "rtnm": "Telegraph Ave",
                        "rtclr": "#3366cc",
                        "rtdd": "51A",
                        "rtpidatafeed": "AC_TRANSIT_BT"
                    }
                ],
                "error": []
            }
        }
        """
        setup(mockJSON: jsonString.data(using: .utf8))

        let result = try await sut.line()
        #expect(result.routes.count == 1)
        #expect(result.routes[0].rt == BusTimeRoute.sample.rt)
        #expect(result.routes[0].rtnm == BusTimeRoute.sample.rtnm)
        #expect(result.routes[0].rtclr == BusTimeRoute.sample.rtclr)
        #expect(result.routes[0].rtdd == BusTimeRoute.sample.rtdd)
        #expect(result.routes[0].rtpidatafeed == BusTimeRoute.sample.rtpidatafeed)
    }

    @Test("test .locale() success case")
    func locale() async throws {
        let jsonString = """
        {
            "bustime-response": {
                "locale": [
                    { "localestring": "en", "displayname": "English" }
                ],
                "error": []
            }
        }
        """
        setup(mockJSON: jsonString.data(using: .utf8))

        let result = try await sut.locale()
        #expect(result.locale.count == 1)
        #expect(result.locale[0].localeString == BusTimeLocale.sample.localeString)
        #expect(result.locale[0].displayName == BusTimeLocale.sample.displayName)
    }

    @Test("test .pattern() success case")
    func pattern() async throws {
        let jsonString = """
        {
            "bustime-response": {
                "ptr": [
                    {
                        "pid": 12345,
                        "ln": 52800,
                        "rtdir": "TO DOWNTOWN BERKELEY",
                        "pt": [
                            {
                                "seq": 1,
                                "typ": "S",
                                "stpid": "55123",
                                "stpnm": "Telegraph Ave & Ashby Ave",
                                "pdist": 0,
                                "lat": 37.8558,
                                "lon": -122.2597
                            }
                        ]
                    }
                ],
                "error": []
            }
        }
        """
        setup(mockJSON: jsonString.data(using: .utf8))

        let result = try await sut.pattern(route: "51A")
        #expect(result.ptr.count == 1)
        #expect(result.ptr[0].pid == Pattern.sample.pid)
        #expect(result.ptr[0].ln == Pattern.sample.ln)
        #expect(result.ptr[0].rtdir == Pattern.sample.rtdir)
        #expect(result.ptr[0].pt.count == 1)
        #expect(result.ptr[0].pt[0].seq == PatternPoint.sample.seq)
        #expect(result.ptr[0].pt[0].typ == PatternPoint.sample.typ)
        #expect(result.ptr[0].pt[0].stpid == PatternPoint.sample.stpid)
        #expect(result.ptr[0].pt[0].stpnm == PatternPoint.sample.stpnm)
        #expect(result.ptr[0].pt[0].lat == PatternPoint.sample.lat)
        #expect(result.ptr[0].pt[0].lon == PatternPoint.sample.lon)
    }
}

// MARK: - mocks

private struct MockRequestPerformer: RequestPerformable {
    var fixture: Data?

    func perform<T: Decodable & Sendable>(request: Request, decodeTo decodableObject: T.Type) async throws -> T {
        guard let fixture else {
            throw NSError(domain: "no fixture", code: -1)
        }
        return try JSONDecoder().decode(decodableObject, from: fixture)
    }
}

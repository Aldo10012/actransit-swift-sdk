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

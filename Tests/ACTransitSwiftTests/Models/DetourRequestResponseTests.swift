@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test DetourRequestResponse")
final class DetourRequestResponseTests {
    @Test("init stores detours and error")
    func initStoresDetours() {
        let detour = Detour.sample
        let response = DetourRequestResponse(dtrs: [detour], error: nil)
        #expect(response.dtrs.count == 1)
        #expect(response.dtrs[0].id == detour.id)
        #expect(response.error == nil)
    }
}

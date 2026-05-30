@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test ServiceBulletinRequestResponse")
final class ServiceBulletinRequestResponseTests {
    @Test("init stores bulletins and error")
    func initStoresBulletins() {
        let bulletin = Bulletin.sample
        let response = ServiceBulletinRequestResponse(sb: [bulletin], error: nil)
        #expect(response.sb.count == 1)
        #expect(response.sb[0].nm == bulletin.nm)
        #expect(response.error == nil)
    }
}

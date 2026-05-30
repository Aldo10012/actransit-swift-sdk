@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test LocaleRequestResponse")
final class LocaleRequestResponseTests {
    @Test("init stores locales and error")
    func initStoresLocales() {
        let locale = BusTimeLocale.sample
        let response = LocaleRequestResponse(locale: [locale], error: nil)
        #expect(response.locale.count == 1)
        #expect(response.locale[0].localeString == locale.localeString)
        #expect(response.error == nil)
    }
}

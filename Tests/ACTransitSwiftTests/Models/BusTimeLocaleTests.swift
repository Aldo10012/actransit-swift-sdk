@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test BusTimeLocale")
final class BusTimeLocaleTests {
    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = BusTimeLocale.make(localeString: "es")
        #expect(result.localeString == "es")
        #expect(result.displayName == BusTimeLocale.sample.displayName)
    }

    @Test("LocaleRequestResponse init stores locales and error")
    func localeRequestResponseInit() {
        let locale = BusTimeLocale.sample
        let response = LocaleRequestResponse(locale: [locale], error: nil)
        #expect(response.locale.count == 1)
        #expect(response.locale[0].localeString == locale.localeString)
        #expect(response.error == nil)
    }
}

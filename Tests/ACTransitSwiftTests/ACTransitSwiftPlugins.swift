@testable import ACTransitSwift
import Testing

@Suite("Test ACTransitSwiftPlugins")
struct ACTransitSwiftPluginsTests {
    @Test("test installing api token")
    func installingAPIToken() {
        let apiTokenWithoutInstall = ACTSwiftPlugins.apiToken
        #expect(apiTokenWithoutInstall == "")

        ACTSwiftPlugins.install(token: "my_api_token")
        let apiTokenWithInstall = ACTSwiftPlugins.apiToken
        #expect(apiTokenWithInstall == "my_api_token")

        ACTSwiftPlugins.cleanup()
        let apiTokenAfterCleanup = ACTSwiftPlugins.apiToken
        #expect(apiTokenAfterCleanup == "")
    }
}

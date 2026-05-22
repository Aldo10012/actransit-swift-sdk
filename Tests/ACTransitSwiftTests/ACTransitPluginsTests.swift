@testable import ACTransitSwift
import Testing

@Suite("Test ACTransitPlugins")
struct ACTransitPluginsTests {
    @Test("test installing api token")
    func installingAPIToken() {
        let apiTokenWithoutInstall = ACTransitPlugins.apiToken
        #expect(apiTokenWithoutInstall.isEmpty)

        ACTransitPlugins.install(token: "my_api_token")
        let apiTokenWithInstall = ACTransitPlugins.apiToken
        #expect(apiTokenWithInstall == "my_api_token")

        ACTransitPlugins.cleanup()
        let apiTokenAfterCleanup = ACTransitPlugins.apiToken
        #expect(apiTokenAfterCleanup.isEmpty)
    }
}

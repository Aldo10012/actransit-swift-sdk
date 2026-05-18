@testable import ACTransitSwift
import Testing

@Suite("Test ACTransitSwiftPlugins")
struct ACTransitSwiftPluginsTests {
    @Test("test installing api token")
    func installingAPIToken() async throws {
        let apiTokenWithoutInstall = await ACTransitSwiftPlugins.apiToken
        #expect(apiTokenWithoutInstall == nil)

        await ACTransitSwiftPlugins.install(token: "my_api_token")
        let apiTokenWithInstall = await ACTransitSwiftPlugins.apiToken
        #expect(apiTokenWithInstall == "my_api_token")

        await ACTransitSwiftPlugins.cleanup()
        let apiTokenAfterCleanup = await ACTransitSwiftPlugins.apiToken
        #expect(apiTokenAfterCleanup == nil)
    }
}

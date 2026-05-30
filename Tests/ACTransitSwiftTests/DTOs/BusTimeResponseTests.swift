@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test BusTimeResponse")
final class BusTimeResponseTests {
    @Test("decodes value from bustime-response key")
    func decodesValueFromBustimeResponseKey() throws {
        let json = """
        {
            "bustime-response": {
                "rt": "51A",
                "rtnm": "Telegraph Ave",
                "rtclr": "#3366cc",
                "rtdd": "51A"
            }
        }
        """.data(using: .utf8)!
        let response = try JSONDecoder().decode(BusTimeResponse<BusTimeRoute>.self, from: json)
        #expect(response.value.rt == "51A")
        #expect(response.value.rtnm == "Telegraph Ave")
    }
}

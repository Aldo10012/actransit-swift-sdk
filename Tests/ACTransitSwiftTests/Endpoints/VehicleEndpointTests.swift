@testable import ACTransitSwift
import EZNetworking
import Foundation
import Testing

@Suite("Test VehicleEndpoint")
final class VehicleEndpointTests {
    enum Constants {
        static let tokenKey = "token"
        static let mockToken = "mockToken"
    }

    @Test("test VehicleEndpoint.vehicle(vehicleId:)")
    func vehicle() {
        let endpoint = VehicleEndpoint.vehicle(vehicleId: 1505)
        let request = endpoint.getRequest(token: Constants.mockToken)

        #expect(endpoint.path == "/vehicle/1505")
        #expect(request.httpMethod == .GET)
        #expect(request.baseUrl == "https://api.actransit.org/transit/vehicle/1505")
        #expect(request.parameters == [HTTPParameter(key: Constants.tokenKey, value: Constants.mockToken)])
    }
}

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

    @Test("test VehicleEndpoint.characteristics(vehicleId:) without vehicleId")
    func characteristicsAll() {
        let endpoint = VehicleEndpoint.characteristics()
        let request = endpoint.getRequest(token: Constants.mockToken)

        #expect(endpoint.path == "/vehicle/characteristics")
        #expect(request.httpMethod == .GET)
        #expect(request.baseUrl == "https://api.actransit.org/transit/vehicle/characteristics")
        #expect(request.parameters == [HTTPParameter(key: Constants.tokenKey, value: Constants.mockToken)])
    }

    @Test("test VehicleEndpoint.characteristics(vehicleId:) with vehicleId")
    func characteristicsFiltered() {
        let endpoint = VehicleEndpoint.characteristics(vehicleId: "1505")
        let request = endpoint.getRequest(token: Constants.mockToken)

        #expect(endpoint.path == "/vehicle/characteristics")
        #expect(request.httpMethod == .GET)
        #expect((request.parameters ?? []).contains(HTTPParameter(key: "vehicleId", value: "1505")))
        #expect((request.parameters ?? []).contains(HTTPParameter(key: Constants.tokenKey, value: Constants.mockToken)))
    }

    @Test("test VehicleEndpoint.vehicleCharacteristics(vehicleId:)")
    func vehicleCharacteristics() {
        let endpoint = VehicleEndpoint.vehicleCharacteristics(vehicleId: "1505")
        let request = endpoint.getRequest(token: Constants.mockToken)

        #expect(endpoint.path == "/vehicle/1505/characteristics")
        #expect(request.httpMethod == .GET)
        #expect(request.baseUrl == "https://api.actransit.org/transit/vehicle/1505/characteristics")
        #expect(request.parameters == [HTTPParameter(key: Constants.tokenKey, value: Constants.mockToken)])
    }

    @Test("test VehicleEndpoint.realtimeAttributes() without filters")
    func realtimeAttributesAll() {
        let endpoint = VehicleEndpoint.realtimeAttributes()
        let request = endpoint.getRequest(token: Constants.mockToken)

        #expect(endpoint.path == "/vehicle/realtimeattributes")
        #expect(request.httpMethod == .GET)
        #expect(request.baseUrl == "https://api.actransit.org/transit/vehicle/realtimeattributes")
        #expect(request.parameters == [HTTPParameter(key: Constants.tokenKey, value: Constants.mockToken)])
    }

    @Test("test VehicleEndpoint.realtimeAttributes() with filters")
    func realtimeAttributesFiltered() {
        let endpoint = VehicleEndpoint.realtimeAttributes(vehicleId: "1505", routeName: "51A")
        let request = endpoint.getRequest(token: Constants.mockToken)

        #expect(endpoint.path == "/vehicle/realtimeattributes")
        #expect(request.httpMethod == .GET)
        #expect((request.parameters ?? []).contains(HTTPParameter(key: "vehicleId", value: "1505")))
        #expect((request.parameters ?? []).contains(HTTPParameter(key: "routename", value: "51A")))
        #expect((request.parameters ?? []).contains(HTTPParameter(key: Constants.tokenKey, value: Constants.mockToken)))
    }

    @Test("test VehicleEndpoint.vehicleRealtimeAttributes(vehicleId:)")
    func vehicleRealtimeAttributes() {
        let endpoint = VehicleEndpoint.vehicleRealtimeAttributes(vehicleId: "1505")
        let request = endpoint.getRequest(token: Constants.mockToken)

        #expect(endpoint.path == "/vehicle/1505/realtimeattributes")
        #expect(request.httpMethod == .GET)
        #expect(request.baseUrl == "https://api.actransit.org/transit/vehicle/1505/realtimeattributes")
        #expect(request.parameters == [HTTPParameter(key: Constants.tokenKey, value: Constants.mockToken)])
    }

    @Test("test VehicleEndpoint.vehicleRealtimeAttributes(vehicleId:routeName:) with routeName")
    func vehicleRealtimeAttributesWithRoute() {
        let endpoint = VehicleEndpoint.vehicleRealtimeAttributes(vehicleId: "1505", routeName: "51A")
        let request = endpoint.getRequest(token: Constants.mockToken)

        #expect(endpoint.path == "/vehicle/1505/realtimeattributes")
        #expect((request.parameters ?? []).contains(HTTPParameter(key: "routename", value: "51A")))
        #expect((request.parameters ?? []).contains(HTTPParameter(key: Constants.tokenKey, value: Constants.mockToken)))
    }

    @Test("test VehicleEndpoint.routeRealtimeAttributes(routeName:)")
    func routeRealtimeAttributes() {
        let endpoint = VehicleEndpoint.routeRealtimeAttributes(routeName: "51A")
        let request = endpoint.getRequest(token: Constants.mockToken)

        #expect(endpoint.path == "/vehicle/route/51A/realtimeattributes")
        #expect(request.httpMethod == .GET)
        #expect(request.baseUrl == "https://api.actransit.org/transit/vehicle/route/51A/realtimeattributes")
        #expect(request.parameters == [HTTPParameter(key: Constants.tokenKey, value: Constants.mockToken)])
    }

    @Test("test VehicleEndpoint.routeRealtimeAttributes(routeName:vehicleId:) with vehicleId")
    func routeRealtimeAttributesWithVehicleId() {
        let endpoint = VehicleEndpoint.routeRealtimeAttributes(routeName: "51A", vehicleId: "1505")
        let request = endpoint.getRequest(token: Constants.mockToken)

        #expect(endpoint.path == "/vehicle/route/51A/realtimeattributes")
        #expect((request.parameters ?? []).contains(HTTPParameter(key: "vehicleId", value: "1505")))
        #expect((request.parameters ?? []).contains(HTTPParameter(key: Constants.tokenKey, value: Constants.mockToken)))
    }

    @Test("test VehicleEndpoint.bulkRealtimeAttributes(vehicles:)")
    func bulkRealtimeAttributes() {
        let endpoint = VehicleEndpoint.bulkRealtimeAttributes(vehicles: ["1505", "1506"])
        let request = endpoint.getRequest(token: Constants.mockToken)

        #expect(endpoint.path == "/vehicle/realtimeattributes")
        #expect(request.httpMethod == .POST)
        #expect(request.baseUrl == "https://api.actransit.org/transit/vehicle/realtimeattributes")
        #expect((request.parameters ?? []).contains(HTTPParameter(key: Constants.tokenKey, value: Constants.mockToken)))
        #expect(request.body != nil)
    }

    @Test("test VehicleEndpoint.bulkRealtimeAttributes(vehicles:route:) includes route in body")
    func bulkRealtimeAttributesWithRoute() throws {
        let endpoint = VehicleEndpoint.bulkRealtimeAttributes(vehicles: ["1505"], route: "72")
        let request = endpoint.getRequest(token: Constants.mockToken)

        #expect(request.httpMethod == .POST)
        let bodyData = try #require(request.body?.toData())
        let json = try #require(try JSONSerialization.jsonObject(with: bodyData) as? [String: Any])
        #expect(json["Route"] as? String == "72")
        #expect((json["Vehicles"] as? [String]) == ["1505"])
    }
}

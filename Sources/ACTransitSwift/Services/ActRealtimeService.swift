import EZNetworking
import Foundation

public struct ActRealtimeService {
    private let token: String
    private let performer: RequestPerformable

    init(token: String, performer: RequestPerformable) {
        self.token = token
        self.performer = performer
    }

    /// Returns active detours affecting transit service.
    /// - Parameters:
    ///   - route: Single route designator (e.g., `20`, `NL`). Optional.
    ///   - direction: Route direction; requires `route`. Optional.
    ///   - callback: JSONP callback function name. Optional.
    public func detour(route: String? = nil, direction: String? = nil, callback: String? = nil) async throws -> DetourRequestResponse {
        let response = try await performer.perform(
            request: ActRealtimeEndpoint.detour(route: route, direction: direction, callback: callback).getRequest(token: token),
            decodeTo: RequestResponseOfDetourRequestResponse.self
        )
        return response.value
    }

    /// Returns the set of directions serviced by a specified route.
    /// - Parameters:
    ///   - route: Single route designator (e.g., `20`, `NL`).
    ///   - callback: JSONP callback function name. Optional.
    public func direction(route: String, callback: String? = nil) async throws -> DirectionRequestResponse {
        let response = try await performer.perform(
            request: ActRealtimeEndpoint.direction(route: route, callback: callback).getRequest(token: token),
            decodeTo: RequestResponseOfDirectionRequestResponse.self
        )
        return response.value
    }

    /// Returns the set of all routes serviced by the system.
    /// - Parameters:
    ///   - callback: JSONP callback function name. Optional.
    public func line(callback: String? = nil) async throws -> RouteRequestResponse {
        let response = try await performer.perform(
            request: ActRealtimeEndpoint.line(callback: callback).getRequest(token: token),
            decodeTo: RequestResponseOfRouteRequestResponse.self
        )
        return response.value
    }

    /// Returns available language locales for the BusTime system.
    /// - Parameters:
    ///   - callback: JSONP callback function name. Optional.
    public func locale(callback: String? = nil) async throws -> LocaleRequestResponse {
        let response = try await performer.perform(
            request: ActRealtimeEndpoint.locale(callback: callback).getRequest(token: token),
            decodeTo: RequestResponseOfLocaleRequestResponse.self
        )
        return response.value
    }

    /// Returns geo-positional points and stops describing route pattern layouts.
    /// - Parameters:
    ///   - patternIds: Comma-delimited list of pattern IDs (max 10). Mutually exclusive with `route`. Optional.
    ///   - route: Single route identifier to return all active patterns. Mutually exclusive with `patternIds`. Optional.
    ///   - callback: JSONP callback function name. Optional.
    public func pattern(patternIds: String? = nil, route: String? = nil, callback: String? = nil) async throws -> PatternRequestResponse {
        let response = try await performer.perform(
            request: ActRealtimeEndpoint.pattern(patternIds: patternIds, route: route, callback: callback).getRequest(token: token),
            decodeTo: RequestResponseOfPatternRequestResponse.self
        )
        return response.value
    }

    /// Returns real-time arrival/departure predictions for stops or vehicles.
    /// - Parameters:
    ///   - stopId: Comma-delimited stop IDs (max 10). Mutually exclusive with `vehicleId`. Optional.
    ///   - route: Comma-delimited route designators to filter results. Optional.
    ///   - vehicleId: Comma-delimited vehicle IDs (max 10). Mutually exclusive with `stopId`. Optional.
    ///   - top: Maximum number of predictions to return. Optional.
    ///   - tmres: Time resolution: `s` (seconds) or `m` (minutes). Defaults to `m`. Optional.
    ///   - showocprd: Whether to show occupancy prediction data. Optional.
    ///   - callback: JSONP callback function name. Optional.
    public func prediction(stopId: String? = nil, route: String? = nil, vehicleId: String? = nil, top: Int? = nil, tmres: String? = nil, showocprd: Bool? = nil, callback: String? = nil) async throws -> PredictionRequestResponse {
        let response = try await performer.perform(
            request: ActRealtimeEndpoint.prediction(stopId: stopId, route: route, vehicleId: vehicleId, top: top, tmres: tmres, showocprd: showocprd, callback: callback).getRequest(token: token),
            decodeTo: RequestResponseOfPredictionRequestResponse.self
        )
        return response.value
    }

    /// Returns the current BusTime system date and time, for client synchronization.
    /// - Parameters:
    ///   - unixTime: If true, returns milliseconds elapsed since Unix epoch (UTC). Optional.
    ///   - callback: JSONP callback function name. Optional.
    public func time(unixTime: Bool? = nil, callback: String? = nil) async throws -> TimeRequestResponse {
        let response = try await performer.perform(
            request: ActRealtimeEndpoint.time(unixTime: unixTime, callback: callback).getRequest(token: token),
            decodeTo: RequestResponseOfTimeRequestResponse.self
        )
        return response.value
    }

    /// Returns active service bulletins for specified routes or stops.
    /// - Parameters:
    ///   - routes: Comma-delimited route designators. Required if `stopId` is not provided. Optional.
    ///   - direction: Single route direction. Optional.
    ///   - stopId: Comma-delimited stop IDs. Required if `routes` is not provided. Optional.
    ///   - callback: JSONP callback function name. Optional.
    public func serviceBulletin(routes: String? = nil, direction: String? = nil, stopId: String? = nil, callback: String? = nil) async throws -> ServiceBulletinRequestResponse {
        let response = try await performer.perform(
            request: ActRealtimeEndpoint.serviceBulletin(routes: routes, direction: direction, stopId: stopId, callback: callback).getRequest(token: token),
            decodeTo: RequestResponseOfServiceBulletinRequestResponse.self
        )
        return response.value
    }

    /// Returns stops for a route/direction pair, or looks up stops by ID.
    /// - Parameters:
    ///   - route: Single route designator. Required with `direction` if `stopId` is not provided. Optional.
    ///   - direction: Single route direction. Required with `route` if `stopId` is not provided. Optional.
    ///   - stopId: Comma-delimited stop IDs (up to 10). Mutually exclusive with `route`/`direction`. Optional.
    ///   - callback: JSONP callback function name. Optional.
    public func stop(route: String? = nil, direction: String? = nil, stopId: String? = nil, callback: String? = nil) async throws -> StopRequestResponse {
        let response = try await performer.perform(
            request: ActRealtimeEndpoint.stop(route: route, direction: direction, stopId: stopId, callback: callback).getRequest(token: token),
            decodeTo: RequestResponseOfStopRequestResponse.self
        )
        return response.value
    }

    /// Returns all stops, optionally filtered to a single route.
    /// - Parameters:
    ///   - route: Single route designator to filter stops. Optional.
    ///   - limitFields: If true, return only `stpid` and `stpnm`. Optional.
    ///   - callback: JSONP callback function name. Optional.
    public func allStops(route: String? = nil, limitFields: Bool? = nil, callback: String? = nil) async throws -> StopRequestResponse {
        let response = try await performer.perform(
            request: ActRealtimeEndpoint.allStops(route: route, limitFields: limitFields, callback: callback).getRequest(token: token),
            decodeTo: RequestResponseOfStopRequestResponse.self
        )
        return response.value
    }
}

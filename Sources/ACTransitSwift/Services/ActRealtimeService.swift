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
}

import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=ServiceBulletinRequestResponse
public struct ServiceBulletinRequestResponse: Codable, Sendable {
    /// Active service bulletins.
    public let sb: [Bulletin]
    /// Errors from request processing.
    public let error: [BusTimeError]?

    public init(sb: [Bulletin], error: [BusTimeError]? = nil) {
        self.sb = sb
        self.error = error
    }
}

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=RequestResponseOfServiceBulletinRequestResponse
public typealias RequestResponseOfServiceBulletinRequestResponse = BusTimeResponse<ServiceBulletinRequestResponse>

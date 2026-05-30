import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=InfoUrl
public struct InfoUrl: Codable, Sendable {
    public let url: String

    public init(url: String) {
        self.url = url
    }

    enum CodingKeys: String, CodingKey {
        case url = "Url"
    }

    public static let sample = InfoUrl(url: "https://511.org/transit/real-time-arrivals")

    public static func make(url: String = sample.url) -> InfoUrl {
        InfoUrl(url: url)
    }
}

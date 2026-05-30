import Foundation

public struct BusTimeResponse<T: Decodable & Sendable>: Decodable, Sendable {
    public let value: T

    private enum Keys: String, CodingKey {
        case bustimeResponse = "bustime-response"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        value = try container.decode(T.self, forKey: .bustimeResponse)
    }
}

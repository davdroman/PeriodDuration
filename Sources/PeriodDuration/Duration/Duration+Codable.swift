import Foundation

extension Duration: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        guard let _self = Self(iso8601: rawValue) else {
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Invalid Duration ISO 8601 value \"\(rawValue)\""
            )
        }
        self = _self
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.formatted(style: .iso8601))
    }
}

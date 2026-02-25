import Foundation

extension Period: Codable {
	public init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		let rawValue = try container.decode(String.self)
		do {
			self = try Period(rawValue, format: .iso8601)
		} catch {
			throw DecodingError.dataCorruptedError(
				in: container,
				debugDescription: "Invalid ISO 8601 duration \"\(rawValue)\"",
			)
		}
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.singleValueContainer()
		try container.encode(self.formatted(.iso8601))
	}
}

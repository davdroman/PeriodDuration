import Foundation

extension PeriodDuration: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        guard let _self = Self(rawValue: rawValue) else {
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Invalid PeriodDuration rawValue \"\(rawValue)\""
            )
        }
        self = _self
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}

extension PeriodDuration {
    init?(rawValue: String) {
        guard
            let period = Period(rawValue: rawValue),
            let duration = Duration(rawValue: rawValue)
        else {
            return nil
        }
        self.init(period: period, duration: duration)
    }

    var rawValue: String {
        var result = ""
        result += "P"
        result += self.years.withSuffix("Y")
        result += self.months.withSuffix("M")
        result += self.days.withSuffix("D")

        guard !duration.isBlank else { return result }
        result += "T"
        result += self.hours.withSuffix("H")
        result += self.minutes.withSuffix("M")
        result += self.seconds.withSuffix("S")

        return result
    }
}

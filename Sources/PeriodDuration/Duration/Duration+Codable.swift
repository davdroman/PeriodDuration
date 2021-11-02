import Foundation

extension Duration: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        guard let _self = Self(rawValue: rawValue) else {
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Invalid Duration rawValue \"\(rawValue)\""
            )
        }
        self = _self
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}

extension Duration {
    init?(rawValue: String) {
        guard rawValue.range(of: validationRegex, options: .regularExpression) != nil else {
            return nil
        }

        // Gets `TnHnMnS` substring, then drops the `T` designator to return `nHnMnS`
        guard let rawDuration = rawValue
            .firstIndex(of: "T")
            .map({ rawValue[$0...].dropFirst() })
            .map(String.init)
        else {
            self = Duration()
            return
        }

        let amounts = rawDuration.amounts(forComponents: ["H", "M", "S"])

        self.init(
            hours: amounts["H"],
            minutes: amounts["M"],
            seconds: amounts["S"]
        )
    }

    var rawValue: String {
        var result = ""
        result += "PT"
        result += self.hours.withSuffix("H")
        result += self.minutes.withSuffix("M")
        result += self.seconds.withSuffix("S")
        return result
    }
}

import Foundation

extension Period: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        guard let _self = Self(rawValue: rawValue) else {
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Invalid Period rawValue \"\(rawValue)\""
            )
        }
        self = _self
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}

extension Period {
    init?(rawValue: String) {
        guard rawValue.range(of: validationRegex, options: .regularExpression) != nil else {
            return nil
        }

        // Gets `PnYnMnWnD` substring, then drops the `P` designator to return `nYnMnWnD`
        let rawPeriod = String(
            rawValue.firstIndex(of: "T").map { rawValue[..<$0].dropFirst() }
            ??
            rawValue.dropFirst()
        )

        let amounts = rawPeriod.amounts(forComponents: ["Y", "M", "W", "D"])

        self.init(
            years: amounts["Y"],
            months: amounts["M"],
            days: amounts["W"].map({ $0 * 7 }) + amounts["D"]
        )
    }

    var rawValue: String {
        var result = ""
        result += "P"
        result += self.years.withSuffix("Y")
        result += self.months.withSuffix("M")
        result += self.days.withSuffix("D")
        return result
    }
}

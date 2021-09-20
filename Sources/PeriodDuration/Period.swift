import Foundation

public struct Period: Codable, Hashable {
    public var years: Int?
    public var months: Int?
    public var days: Int?

    public init(years: Int? = nil, months: Int? = nil, days: Int? = nil) {
        self.years = years
        self.months = months
        self.days = days
    }
}

extension Period {
    public var isBlank: Bool {
        [years, months, days].compactMap { $0 }.isEmpty
    }

    public var isBlankOrZero: Bool {
        isBlank || [years, months, days].allSatisfy(\.isNilOrZero)
    }
}

extension Period {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        guard let _self = Self(rawValue: rawValue) else {
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Invalid Period rawValue '\(rawValue)'"
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
    public init?(rawValue: String) {
        guard rawValue.range(of: PeriodDuration.validationRegex, options: .regularExpression) != nil else {
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

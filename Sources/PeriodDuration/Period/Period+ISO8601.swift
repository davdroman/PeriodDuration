import Foundation

extension Period {
    public enum StandardFormatStyle {
        case iso8601
    }
}

extension Period {
    public init?(iso8601 rawValue: String) {
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

    public func formatted(style: StandardFormatStyle) -> String {
        switch style {
        case .iso8601:
            var result = ""
            result += "P"
            result += self.years.withSuffix("Y")
            result += self.months.withSuffix("M")
            result += self.days.withSuffix("D")
            return result
        }
    }
}

import Foundation

extension Duration {
    public enum StandardFormatStyle {
        case iso8601
    }
}

extension Duration {
    public init?(iso8601 rawValue: String) {
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

    public func formatted(style: StandardFormatStyle) -> String {
        switch style {
        case .iso8601:
            var result = ""
            result += "PT"
            result += self.hours.withSuffix("H")
            result += self.minutes.withSuffix("M")
            result += self.seconds.withSuffix("S")
            return result
        }
    }
}

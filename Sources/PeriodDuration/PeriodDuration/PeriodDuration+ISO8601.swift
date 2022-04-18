import Foundation

extension PeriodDuration {
    public enum StandardFormatStyle {
        case iso8601
    }
}

extension PeriodDuration {
    public init?(iso8601 rawValue: String) {
        guard
            let period = Period(iso8601: rawValue),
            let duration = Duration(iso8601: rawValue)
        else {
            return nil
        }
        self.init(period: period, duration: duration)
    }

    public func formatted(style: StandardFormatStyle) -> String {
        switch style {
        case .iso8601:
            var result = ""
            result += "P"
            result += self.years.withSuffix("Y")
            result += self.months.withSuffix("M")
            result += self.days.withSuffix("D")

            guard duration != .zero else { return result }
            result += "T"
            result += self.hours.withSuffix("H")
            result += self.minutes.withSuffix("M")
            result += self.seconds.withSuffix("S")

            return result
        }
    }
}

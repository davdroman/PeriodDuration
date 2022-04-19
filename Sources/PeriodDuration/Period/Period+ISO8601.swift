import Foundation

extension Period {
    public enum StandardFormatStyle {
        case iso8601
    }
}

extension Period {
    public init?(iso8601 rawValue: String) {
        guard let _self = PeriodDuration(iso8601: rawValue)?.period else {
            return nil
        }
        self = _self
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

import Foundation

extension Duration {
    public enum StandardFormatStyle {
        case iso8601
    }
}

extension Duration {
    public init?(iso8601 rawValue: String) {
        guard let _self = PeriodDuration(iso8601: rawValue)?.duration else {
            return nil
        }
        self = _self
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

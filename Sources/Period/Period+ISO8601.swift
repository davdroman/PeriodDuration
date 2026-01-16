import Foundation

extension Period {
    public enum StandardFormatStyle {
        case iso8601
    }
}

extension Period {
    public init?(iso8601 rawValue: String) {
        do {
            self = try Parsers.period.parse(rawValue)
        } catch {
            #if DEBUG
            print("[\(Self.self)]", error)
            #endif
            return nil
        }
    }

    public func formatted(style: StandardFormatStyle) -> String {
        switch style {
        case .iso8601:
            var result = ""
            result += "P"
            result += self.years.withSuffix("Y")
            result += self.months.withSuffix("M")
            result += self.days.withSuffix("D")

            guard self.hours != 0 || self.minutes != 0 || self.seconds != 0 else { return result }
            result += "T"
            result += self.hours.withSuffix("H")
            result += self.minutes.withSuffix("M")
            result += self.seconds.withSuffix("S")

            return result
        }
    }
}

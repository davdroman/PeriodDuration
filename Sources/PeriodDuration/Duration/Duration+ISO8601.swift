import Foundation

extension Duration {
    public enum StandardFormatStyle {
        case iso8601
    }
}

extension Duration {
    public init?(iso8601 rawValue: String) {
        do {
            self = try Parsers.duration.parse(rawValue)
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
            result += "PT"
            result += self.hours.withSuffix("H")
            result += self.minutes.withSuffix("M")
            result += self.seconds.withSuffix("S")
            return result
        }
    }
}

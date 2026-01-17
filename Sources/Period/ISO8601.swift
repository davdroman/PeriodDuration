import Foundation
import Parsing

extension Period {
    public struct ISO8601FormatStyle: ParseableFormatStyle, ParseStrategy {
        public init() {}

        public func format(_ value: Period) -> String {
            var result = "P"
            result += value.years.withSuffix("Y")
            result += value.months.withSuffix("M")
            result += value.days.withSuffix("D")

            guard value.hours != 0 || value.minutes != 0 || value.seconds != 0 else { return result }
            result += "T"
            result += value.hours.withSuffix("H")
            result += value.minutes.withSuffix("M")
            result += value.seconds.withSuffix("S")

            return result
        }

        public var parseStrategy: Self { self }

        public func parse(_ value: String) throws -> Period {
            try Parser().parse(value)
        }

        struct Parser: Parsing.Parser, Sendable {
            var body: some Parsing.Parser<Substring.UTF8View, Period> {
                Parse {
                    Skip {
                        "P".utf8
                        Not {
                            Digits(1...)
                            Whitespace(0..., .horizontal)
                            End()
                        }
                    }
                    digitsAndUnit("Y".utf8)
                    digitsAndUnit("M".utf8)
                    digitsAndUnit("W".utf8)
                    digitsAndUnit("D".utf8)
                    OneOf {
                        "T".utf8
                        Skip { Rest() }.replaceError(with: ())
                    }
                    digitsAndUnit("H".utf8)
                    digitsAndUnit("M".utf8)
                    digitsAndUnit("S".utf8)
                }
                .map { (years, months, weeks, days, hours, minutes, seconds) in
                    Period(
                        years: years,
                        months: months,
                        days: weeks * 7 + days,
                        hours: hours,
                        minutes: minutes,
                        seconds: seconds
                    )
                }
            }

            func digitsAndUnit(_ unit: String.UTF8View) -> some Parsing.Parser<Substring.UTF8View, Int> {
                Parse {
                    Optionally { Digits(1...) }
                    unit
                }
                .map { $0 ?? 0 }
                .replaceError(with: 0)
                .eraseToAnyParser()
            }
        }
    }
}

extension Period.ISO8601FormatStyle {
    public static var iso8601: Self { .init() }
}

// MARK: Formatting

extension Period {
    public func formatted(_ style: ISO8601FormatStyle) -> String {
        style.format(self)
    }
}

// MARK: Parsing

extension Period {
    public init(_ value: String, format: ISO8601FormatStyle) throws {
        try self.init(value, strategy: format.parseStrategy)
    }

    public init<S: ParseStrategy>(_ value: S.ParseInput, strategy: S) throws where S.ParseOutput == Self {
        self = try strategy.parse(value)
    }
}

fileprivate extension Numeric {
    func withSuffix(_ c: Character) -> String {
        if self == .zero {
            return ""
        } else {
            return "\(self)\(c)"
        }
    }
}

// MARK: Regex

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
extension Period.ISO8601FormatStyle: CustomConsumingRegexComponent {
    public typealias RegexOutput = Period

    public func consuming(_ input: String, startingAt index: String.Index, in bounds: Range<String.Index>) throws -> (upperBound: String.Index, output: Period)? {
        guard index < bounds.upperBound else { return nil }
        var substr = input[index..<bounds.upperBound].utf8
        guard let output = try? Period.ISO8601FormatStyle.Parser().parse(&substr) else {
            return nil
        }
        return (String.Index(substr.startIndex, within: input)!, output)
    }
}

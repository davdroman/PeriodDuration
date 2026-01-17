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

            let hasDatePart = value.years != 0 || value.months != 0 || value.days != 0
            let hasTimePart = value.hours != 0 || value.minutes != 0 || value.seconds != 0

            guard hasTimePart || !hasDatePart else { return result }
            result += "T"
            result += value.hours.withSuffix("H")
            result += value.minutes.withSuffix("M")
            result += hasTimePart ? value.seconds.withSuffix("S") : "0S"

            return result
        }

        public var parseStrategy: Self { self }

        public func parse(_ value: String) throws -> Period {
            try Parser().parse(value)
        }

        struct Parser: Parsing.Parser, Sendable {
            var body: some Parsing.Parser<Substring.UTF8View, Period> {
                Parse {
                    // Leading sign (ISO 8601-2)
                    OneOf {
                        "-".utf8.map { -1 }
                        "+".utf8.map { 1 }
                        Always(1)
                    }
                    Skip {
                        "P".utf8
                        Not {
                            Digits(1...)
                            Whitespace(0..., .horizontal)
                            End()
                        }
                    }
                    signedDigitsAndUnit("Y".utf8)
                    signedDigitsAndUnit("M".utf8)
                    signedDigitsAndUnit("W".utf8)
                    signedDigitsAndUnit("D".utf8)
                    OneOf {
                        "T".utf8
                        Skip { Rest() }.replaceError(with: ())
                    }
                    signedDigitsAndUnit("H".utf8)
                    signedDigitsAndUnit("M".utf8)
                    signedDigitsAndUnit("S".utf8)
                }
                .compactMap { (leadingSign, years, months, weeks, days, hours, minutes, seconds) -> Period? in
                    // Require at least one numeric value
                    let hasValue = [years, months, weeks, days, hours, minutes, seconds].contains { $0 != nil }
                    guard hasValue else { return nil }
                    return Period(
                        years: (years ?? 0) * leadingSign,
                        months: (months ?? 0) * leadingSign,
                        days: ((weeks ?? 0) * 7 + (days ?? 0)) * leadingSign,
                        hours: (hours ?? 0) * leadingSign,
                        minutes: (minutes ?? 0) * leadingSign,
                        seconds: (seconds ?? 0) * leadingSign
                    )
                }
            }

            func signedDigitsAndUnit(_ unit: String.UTF8View) -> some Parsing.Parser<Substring.UTF8View, Int?> {
                OneOf {
                    Parse {
                        OneOf {
                            "-".utf8.map { -1 }
                            "+".utf8.map { 1 }
                            Always(1)
                        }
                        Digits(1...)
                        unit
                    }.map { Optional($0 * $1) }
                    unit.map { Int?.none }
                }
                .replaceError(with: Int?.none)
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

import Foundation
import IssueReporting
import Parsing

extension Period {
    public struct ISO8601FormatStyle: Sendable, Hashable {
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
    }

    public func formatted(_ style: ISO8601FormatStyle) -> String {
        style.format(self)
    }
}

extension Period.ISO8601FormatStyle: FormatStyle {}

extension FormatStyle where Self == Period.ISO8601FormatStyle {
    public static var iso8601: Self { .init() }
}

// MARK: Parsing
extension Period {
    public init?(iso8601 rawValue: String) {
        do {
            self = try ISO8601PeriodParser().parse(rawValue)
        } catch {
            if !isTesting {
                print("[Period]", error)
            }
            return nil
        }
    }
}

fileprivate struct ISO8601PeriodParser: Parser, Sendable {
    var body: some Parser<Substring.UTF8View, Period> {
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

    func digitsAndUnit(_ unit: String.UTF8View) -> some Parser<Substring.UTF8View, Int> {
        Parse {
            Optionally { Digits(1...) }
            unit
        }
        .map { $0 ?? 0 }
        .replaceError(with: 0)
        .eraseToAnyParser()
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

import Foundation
import Parsing

enum Parsers {
    static let years = digitsAndUnit("Y".utf8)
    static let months = digitsAndUnit("M".utf8)
    static let weeks = digitsAndUnit("W".utf8)
    static let days = digitsAndUnit("D".utf8)
    static let hours = digitsAndUnit("H".utf8)
    static let minutes = digitsAndUnit("M".utf8)
    static let seconds = digitsAndUnit("S".utf8)

    static let periodDuration = Parse {
        Skip {
            "P".utf8
            Not {
                Digits(1...)
                Whitespace(0..., .horizontal)
                End()
            }
        }
        Parse {
            years
            months
            weeks
            days
        }
        .map { years, months, weeks, days in
            Period(years: years, months: months, days: weeks * 7 + days)
        }
        Skip {
            OneOf {
                "T".utf8
                Skip { Rest() }.replaceError(with: ())
            }
        }
        Parse {
            hours
            minutes
            seconds
        }
        .map(Duration.init(hours:minutes:seconds:))
    }
    .map(PeriodDuration.init(period:duration:))
}

private extension Parsers {
    static func digitsAndUnit(_ unit: String.UTF8View) -> AnyParser<Substring.UTF8View, Int> {
        OneOf {
            unit.map { 0 }
            Parse {
                Digits(1...)
                unit
            }
            .replaceError(with: 0)
        }
        .eraseToAnyParser()
    }
}

extension Numeric {
    var nilIfZero: Self? {
        self == .zero ? nil : self
    }

    func withSuffix(_ c: Character) -> String {
        if self == .zero {
            return ""
        } else {
            return "\(self)\(c)"
        }
    }
}

#if !os(Linux)
let formatter: DateComponentsFormatter = {
    var formatter = DateComponentsFormatter()
    var calendar = Calendar(identifier: .iso8601)
    calendar.timeZone = TimeZone(secondsFromGMT: 0)!
    formatter.calendar = calendar
    return formatter
}()
#endif

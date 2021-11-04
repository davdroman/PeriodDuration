import Foundation

extension PeriodDuration: CustomStringConvertible {
    public var description: String {
        [
            self.years.map { "\($0) year\($0 == 1 ? "" : "s")" },
            self.months.map { "\($0) month\($0 == 1 ? "" : "s")" },
            self.days.map { "\($0) day\($0 == 1 ? "" : "s")" },
            self.hours.map { "\($0) hour\($0 == 1 ? "" : "s")" },
            self.minutes.map { "\($0) minute\($0 == 1 ? "" : "s")" },
            self.seconds.map { "\($0) second\($0 == 1 ? "" : "s")" },
        ]
        .lazy
        .compactMap { $0 }
        .joined(separator: ", ")
    }
}

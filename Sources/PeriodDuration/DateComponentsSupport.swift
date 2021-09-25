import Foundation

extension PeriodDuration {
    public var asDateComponents: DateComponents {
        DateComponents(
            year: self.years,
            month: self.months,
            day: self.days,
            hour: self.hours,
            minute: self.minutes,
            second: self.seconds
        )
    }
}

extension Period {
    public var asDateComponents: DateComponents {
        DateComponents(
            year: years,
            month: months,
            day: days
        )
    }
}

extension Duration {
    public var asDateComponents: DateComponents {
        DateComponents(
            hour: hours,
            minute: minutes,
            second: seconds
        )
    }
}

#if !os(Linux)
extension DateComponentsFormatter {
    public func string(from periodDuration: PeriodDuration) -> String? {
        string(from: periodDuration.asDateComponents)
    }

    public func string(from period: Period) -> String? {
        string(from: period.asDateComponents)
    }

    public func string(from duration: Duration) -> String? {
        string(from: duration.asDateComponents)
    }
}
#endif

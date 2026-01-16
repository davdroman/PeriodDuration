import Foundation

extension Period {
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

extension DateComponentsFormatter {
    public func string(from period: Period) -> String? {
        string(from: period.asDateComponents)
    }
}

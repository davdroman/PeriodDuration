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

#if !os(Linux)
extension DateComponentsFormatter {
    public func string(from periodDuration: PeriodDuration) -> String? {
        guard !periodDuration.isBlank else {
            return nil
        }
        return string(from: periodDuration.asDateComponents)
    }
}
#endif

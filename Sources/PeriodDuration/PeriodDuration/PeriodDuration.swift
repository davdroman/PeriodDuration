import Foundation

@dynamicMemberLookup
public struct PeriodDuration: Hashable {
    public var period: Period
    public var duration: Duration

    public init(period: Period, duration: Duration) {
        self.period = period
        self.duration = duration
    }

    public init(period: Period) {
        self.period = period
        self.duration = Duration()
    }

    public init(duration: Duration) {
        self.period = Period()
        self.duration = duration
    }

    public init(
        years: Int = 0,
        months: Int = 0,
        days: Int = 0,
        hours: Int = 0,
        minutes: Int = 0,
        seconds: Int = 0
    ) {
        self.init(
            period: Period(years: years, months: months, days: days),
            duration: Duration(hours: hours, minutes: minutes, seconds: seconds)
        )
    }
}

extension PeriodDuration {
    public subscript(dynamicMember keyPath: WritableKeyPath<Period, Int>) -> Int {
        get { period[keyPath: keyPath] }
        set { period[keyPath: keyPath] = newValue }
    }

    public subscript(dynamicMember keyPath: WritableKeyPath<Duration, Int>) -> Int {
        get { duration[keyPath: keyPath] }
        set { duration[keyPath: keyPath] = newValue }
    }
}

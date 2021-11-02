import Foundation

extension PeriodDuration {
    public static prefix func + (rhs: Self) -> Self {
        rhs
    }

    public static prefix func - (rhs: Self) -> Self {
        Self(
            years: rhs.years.map { -$0 },
            months: rhs.months.map { -$0 },
            days: rhs.days.map { -$0 },
            hours: rhs.hours.map { -$0 },
            minutes: rhs.minutes.map { -$0 },
            seconds: rhs.seconds.map { -$0 }
        )
    }
}

import Foundation

extension Period {
    public static prefix func + (rhs: Self) -> Self {
        rhs
    }

    public static prefix func - (rhs: Self) -> Self {
        Period(
            years: -rhs.years,
            months: -rhs.months,
            days: -rhs.days,
            hours: -rhs.hours,
            minutes: -rhs.minutes,
            seconds: -rhs.seconds
        )
    }
}

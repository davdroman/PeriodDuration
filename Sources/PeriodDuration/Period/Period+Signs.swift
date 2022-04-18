import Foundation

extension Period {
    public static prefix func + (rhs: Self) -> Self {
        rhs
    }

    public static prefix func - (rhs: Self) -> Self {
        Self(
            years: -rhs.years,
            months: -rhs.months,
            days: -rhs.days
        )
    }
}

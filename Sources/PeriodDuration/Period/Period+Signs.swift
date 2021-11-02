import Foundation

extension Period {
    public static prefix func + (rhs: Self) -> Self {
        rhs
    }

    public static prefix func - (rhs: Self) -> Self {
        Self(
            years: rhs.years.map { -$0 },
            months: rhs.months.map { -$0 },
            days: rhs.days.map { -$0 }
        )
    }
}

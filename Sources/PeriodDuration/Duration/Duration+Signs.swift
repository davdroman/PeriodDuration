import Foundation

extension Duration {
    public static prefix func + (rhs: Self) -> Self {
        rhs
    }

    public static prefix func - (rhs: Self) -> Self {
        Self(
            hours: rhs.hours.map { -$0 },
            minutes: rhs.minutes.map { -$0 },
            seconds: rhs.seconds.map { -$0 }
        )
    }
}

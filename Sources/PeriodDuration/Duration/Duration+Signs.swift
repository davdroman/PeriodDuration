import Foundation

extension Duration {
    public static prefix func + (rhs: Self) -> Self {
        rhs
    }

    public static prefix func - (rhs: Self) -> Self {
        Self(
            hours: -rhs.hours,
            minutes: -rhs.minutes,
            seconds: -rhs.seconds
        )
    }
}

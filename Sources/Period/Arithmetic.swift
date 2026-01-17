extension Period {
    // MARK: - Addition

    public static func + (lhs: Period, rhs: Period) -> Period {
        Period(
            years: lhs.years + rhs.years,
            months: lhs.months + rhs.months,
            days: lhs.days + rhs.days,
            hours: lhs.hours + rhs.hours,
            minutes: lhs.minutes + rhs.minutes,
            seconds: lhs.seconds + rhs.seconds
        )
    }

    public static func += (lhs: inout Period, rhs: Period) {
        lhs = lhs + rhs
    }

    // MARK: - Subtraction

    public static func - (lhs: Period, rhs: Period) -> Period {
        Period(
            years: lhs.years - rhs.years,
            months: lhs.months - rhs.months,
            days: lhs.days - rhs.days,
            hours: lhs.hours - rhs.hours,
            minutes: lhs.minutes - rhs.minutes,
            seconds: lhs.seconds - rhs.seconds
        )
    }

    public static func -= (lhs: inout Period, rhs: Period) {
        lhs = lhs - rhs
    }

    // MARK: - Scalar Multiplication

    public static func * (lhs: Period, rhs: Int) -> Period {
        Period(
            years: lhs.years * rhs,
            months: lhs.months * rhs,
            days: lhs.days * rhs,
            hours: lhs.hours * rhs,
            minutes: lhs.minutes * rhs,
            seconds: lhs.seconds * rhs
        )
    }

    public static func * (lhs: Int, rhs: Period) -> Period {
        rhs * lhs
    }

    public static func *= (lhs: inout Period, rhs: Int) {
        lhs = lhs * rhs
    }

    // MARK: - Negation

    public mutating func negate() {
        self = -self
    }
}

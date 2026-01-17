import Period
import Testing

struct ArithmeticTests {
    // MARK: - Unary

    @Test func unaryPlus() {
        #expect(+Period.zero == Period.zero)
        #expect(+Period(years: 1, months: 2, days: 3, hours: 4, minutes: 5, seconds: 6) == Period(years: 1, months: 2, days: 3, hours: 4, minutes: 5, seconds: 6))
        #expect(+Period(years: -1, months: -2, days: -3, hours: -4, minutes: -5, seconds: -6) == Period(years: -1, months: -2, days: -3, hours: -4, minutes: -5, seconds: -6))
    }

    @Test func unaryMinus() {
        #expect(-Period.zero == Period.zero)
        #expect(-Period(years: 1, months: 2, days: 3, hours: 4, minutes: 5, seconds: 6) == Period(years: -1, months: -2, days: -3, hours: -4, minutes: -5, seconds: -6))
        #expect(-Period(years: -1, months: -2, days: -3, hours: -4, minutes: -5, seconds: -6) == Period(years: 1, months: 2, days: 3, hours: 4, minutes: 5, seconds: 6))
    }

    // MARK: - Addition

    @Test func addition() {
        let a = Period(years: 1, months: 2, days: 3)
        let b = Period(years: 4, months: 5, days: 6)
        #expect(a + b == Period(years: 5, months: 7, days: 9))
    }

    @Test func additionWithTime() {
        let a = Period(hours: 1, minutes: 30)
        let b = Period(hours: 2, minutes: 45)
        #expect(a + b == Period(hours: 3, minutes: 75))
    }

    @Test func additionCompoundAssignment() {
        var period = Period(years: 1)
        period += Period(months: 6)
        #expect(period == Period(years: 1, months: 6))
    }

    @Test func additionWithZero() {
        let period = Period(years: 1, months: 2)
        #expect(period + .zero == period)
        #expect(.zero + period == period)
    }

    // MARK: - Subtraction

    @Test func subtraction() {
        let a = Period(years: 5, months: 7, days: 9)
        let b = Period(years: 1, months: 2, days: 3)
        #expect(a - b == Period(years: 4, months: 5, days: 6))
    }

    @Test func subtractionResultingInNegative() {
        let a = Period(years: 1)
        let b = Period(years: 3)
        #expect(a - b == Period(years: -2))
    }

    @Test func subtractionCompoundAssignment() {
        var period = Period(years: 5, months: 3)
        period -= Period(months: 1)
        #expect(period == Period(years: 5, months: 2))
    }

    @Test func subtractionFromZero() {
        let period = Period(years: 1, months: 2)
        #expect(.zero - period == -period)
    }

    // MARK: - Scalar Multiplication

    @Test func multiplicationByPositive() {
        let period = Period(years: 1, months: 2, days: 3)
        #expect(period * 2 == Period(years: 2, months: 4, days: 6))
    }

    @Test func multiplicationByZero() {
        let period = Period(years: 1, months: 2, days: 3)
        #expect(period * 0 == .zero)
    }

    @Test func multiplicationByNegative() {
        let period = Period(years: 1, months: 2)
        #expect(period * -1 == Period(years: -1, months: -2))
    }

    @Test func multiplicationCommutative() {
        let period = Period(hours: 5, minutes: 30)
        #expect(period * 3 == 3 * period)
    }

    @Test func multiplicationCompoundAssignment() {
        var period = Period(days: 7)
        period *= 4
        #expect(period == Period(days: 28))
    }

    // MARK: - Negation

    @Test func negate() {
        var period = Period(years: 1, months: -2, days: 3)
        period.negate()
        #expect(period == Period(years: -1, months: 2, days: -3))
    }
}

import Period
import Testing

struct SignsTests {
    @Test func periodSigns() {
        #expect(-Period.zero == Period.zero)
        #expect(-Period(years: 1, months: 2, days: 3, hours: 4, minutes: 5, seconds: 6) == Period(years: -1, months: -2, days: -3, hours: -4, minutes: -5, seconds: -6))
        #expect(-Period(years: -1, months: -2, days: -3, hours: -4, minutes: -5, seconds: -6) == Period(years: 1, months: 2, days: 3, hours: 4, minutes: 5, seconds: 6))

        #expect(+Period.zero == Period.zero)
        #expect(+Period(years: 1, months: 2, days: 3, hours: 4, minutes: 5, seconds: 6) == Period(years: 1, months: 2, days: 3, hours: 4, minutes: 5, seconds: 6))
        #expect(+Period(years: -1, months: -2, days: -3, hours: -4, minutes: -5, seconds: -6) == Period(years: -1, months: -2, days: -3, hours: -4, minutes: -5, seconds: -6))
    }
}

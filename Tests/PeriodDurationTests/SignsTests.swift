import PeriodDuration
import Testing

struct SignsTests {
    @Test func periodDurationSigns() {
        #expect(-PeriodDuration.zero == PeriodDuration.zero)
        #expect(-PeriodDuration(fullProps) == PeriodDuration(years: -1, months: -2, days: -3, hours: -4, minutes: -5, seconds: -6))
        #expect(-PeriodDuration(years: -1, months: -2, days: -3, hours: -4, minutes: -5, seconds: -6) == PeriodDuration(fullProps))

        #expect(+PeriodDuration.zero == PeriodDuration.zero)
        #expect(+PeriodDuration(fullProps) == PeriodDuration(fullProps))
        #expect(+PeriodDuration(years: -1, months: -2, days: -3, hours: -4, minutes: -5, seconds: -6) == PeriodDuration(years: -1, months: -2, days: -3, hours: -4, minutes: -5, seconds: -6))
    }

    @Test func periodSigns() {
        #expect(-Period.zero == Period.zero)
        #expect(-Period(fullProps) == Period(years: -1, months: -2, days: -3))
        #expect(-Period(years: -1, months: -2, days: -3) == Period(fullProps))

        #expect(+Period.zero == Period.zero)
        #expect(+Period(fullProps) == Period(fullProps))
        #expect(+Period(years: -1, months: -2, days: -3) == Period(years: -1, months: -2, days: -3))
    }

    @Test func durationSigns() {
        #expect(-Duration.zero == Duration.zero)
        #expect(-Duration(fullProps) == Duration(hours: -4, minutes: -5, seconds: -6))
        #expect(-Duration(hours: -4, minutes: -5, seconds: -6) == Duration(fullProps))

        #expect(+Duration.zero == Duration.zero)
        #expect(+Duration(fullProps) == Duration(fullProps))
        #expect(+Duration(hours: -4, minutes: -5, seconds: -6) == Duration(hours: -4, minutes: -5, seconds: -6))
    }
}

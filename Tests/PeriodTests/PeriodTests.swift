import Period
import Testing

struct PeriodTests {
    @Test func initWithAllComponents() {
        let period = Period(years: 1, months: 2, days: 3, hours: 4, minutes: 5, seconds: 6)
        #expect(period.years == 1)
        #expect(period.months == 2)
        #expect(period.days == 3)
        #expect(period.hours == 4)
        #expect(period.minutes == 5)
        #expect(period.seconds == 6)
    }

    @Test func initWithDefaults() {
        let period = Period(years: 1)
        #expect(period.years == 1)
        #expect(period.months == 0)
        #expect(period.days == 0)
        #expect(period.hours == 0)
        #expect(period.minutes == 0)
        #expect(period.seconds == 0)
    }

    @Test func initEmpty() {
        let period = Period()
        #expect(period == .zero)
    }

    @Test func zero() {
        let period = Period.zero
        #expect(period.years == 0)
        #expect(period.months == 0)
        #expect(period.days == 0)
        #expect(period.hours == 0)
        #expect(period.minutes == 0)
        #expect(period.seconds == 0)
    }
}

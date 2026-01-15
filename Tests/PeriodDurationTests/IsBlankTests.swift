import PeriodDuration
import Testing

struct ZeroTests {
    @Test func periodDurationZero() {
        let sut = PeriodDuration.zero
        #expect(sut.years == 0)
        #expect(sut.months == 0)
        #expect(sut.days == 0)
        #expect(sut.hours == 0)
        #expect(sut.minutes == 0)
        #expect(sut.seconds == 0)
    }

    @Test func periodZero() {
        let sut = Period.zero
        #expect(sut.years == 0)
        #expect(sut.months == 0)
        #expect(sut.days == 0)
    }

    @Test func durationZero() {
        let sut = Duration.zero
        #expect(sut.hours == 0)
        #expect(sut.minutes == 0)
        #expect(sut.seconds == 0)
    }
}

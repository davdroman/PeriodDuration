import Foundation
import PeriodDuration
import Testing

struct Props {
    var years: Int = 0
    var months: Int = 0
    var days: Int = 0
    var hours: Int = 0
    var minutes: Int = 0
    var seconds: Int = 0
}

extension PeriodDuration {
    init(_ props: Props) {
        self.init(
            years: props.years,
            months: props.months,
            days: props.days,
            hours: props.hours,
            minutes: props.minutes,
            seconds: props.seconds
        )
    }
}

extension Period {
    init(_ props: Props) {
        self.init(
            years: props.years,
            months: props.months,
            days: props.days
        )
    }
}

extension Duration {
    init(_ props: Props) {
        self.init(
            hours: props.hours,
            minutes: props.minutes,
            seconds: props.seconds
        )
    }
}

extension DateComponents {
    init(_ props: Props) {
        self.init(
            year: props.years,
            month: props.months,
            day: props.days,
            hour: props.hours,
            minute: props.minutes,
            second: props.seconds
        )
    }
}

struct PropsTests {
    @Test func initPeriodDurationWithProps() {
        let sut = PeriodDuration(fullProps)
        #expect(sut.years == 1)
        #expect(sut.months == 2)
        #expect(sut.days == 3)
        #expect(sut.hours == 4)
        #expect(sut.minutes == 5)
        #expect(sut.seconds == 6)
    }

    @Test func initPeriodWithProps() {
        let sut = Period(fullProps)
        #expect(sut.years == 1)
        #expect(sut.months == 2)
        #expect(sut.days == 3)
    }

    @Test func initDurationWithProps() {
        let sut = Duration(fullProps)
        #expect(sut.hours == 4)
        #expect(sut.minutes == 5)
        #expect(sut.seconds == 6)
    }

    @Test func initDateComponentsWithProps() {
        let sut = DateComponents(fullProps)
        #expect(sut.year == 1)
        #expect(sut.month == 2)
        #expect(sut.day == 3)
        #expect(sut.hour == 4)
        #expect(sut.minute == 5)
        #expect(sut.second == 6)
    }
}

let zeroProps = Props(years: 0, months: 0, days: 0, hours: 0, minutes: 0, seconds: 0)
let fullProps = Props(years: 1, months: 2, days: 3, hours: 4, minutes: 5, seconds: 6)

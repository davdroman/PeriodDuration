import Foundation
import PeriodDuration
import XCTest

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

final class PropsTests: XCTestCase {
    func testInitPeriodDurationWithProps() {
        let sut = PeriodDuration(fullProps)
        XCTAssertEqual(sut.years, 1)
        XCTAssertEqual(sut.months, 2)
        XCTAssertEqual(sut.days, 3)
        XCTAssertEqual(sut.hours, 4)
        XCTAssertEqual(sut.minutes, 5)
        XCTAssertEqual(sut.seconds, 6)
    }

    func testInitPeriodWithProps() {
        let sut = Period(fullProps)
        XCTAssertEqual(sut.years, 1)
        XCTAssertEqual(sut.months, 2)
        XCTAssertEqual(sut.days, 3)
    }

    func testInitDurationWithProps() {
        let sut = Duration(fullProps)
        XCTAssertEqual(sut.hours, 4)
        XCTAssertEqual(sut.minutes, 5)
        XCTAssertEqual(sut.seconds, 6)
    }

    func testInitDateComponentsWithProps() {
        let sut = DateComponents(fullProps)
        XCTAssertEqual(sut.year, 1)
        XCTAssertEqual(sut.month, 2)
        XCTAssertEqual(sut.day, 3)
        XCTAssertEqual(sut.hour, 4)
        XCTAssertEqual(sut.minute, 5)
        XCTAssertEqual(sut.second, 6)
    }
}

let zeroProps = Props(years: 0, months: 0, days: 0, hours: 0, minutes: 0, seconds: 0)
let fullProps = Props(years: 1, months: 2, days: 3, hours: 4, minutes: 5, seconds: 6)

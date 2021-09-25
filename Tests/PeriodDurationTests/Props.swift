import Foundation
import PeriodDuration
import XCTest

struct Props {
    var years: Int? = nil
    var months: Int? = nil
    var days: Int? = nil
    var hours: Int? = nil
    var minutes: Int? = nil
    var seconds: Int? = nil
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

final class PropsTests: XCTestCase {
    let props = Props(years: 1, months: 2, days: 3, hours: 4, minutes: 5, seconds: 6)

    func testInitPeriodDurationWithProps() {
        let sut = PeriodDuration(props)
        XCTAssertEqual(sut.years, 1)
        XCTAssertEqual(sut.months, 2)
        XCTAssertEqual(sut.days, 3)
        XCTAssertEqual(sut.hours, 4)
        XCTAssertEqual(sut.minutes, 5)
        XCTAssertEqual(sut.seconds, 6)
    }

    func testInitPeriodWithProps() {
        let sut = Period(props)
        XCTAssertEqual(sut.years, 1)
        XCTAssertEqual(sut.months, 2)
        XCTAssertEqual(sut.days, 3)
    }

    func testInitDurationWithProps() {
        let sut = Duration(props)
        XCTAssertEqual(sut.hours, 4)
        XCTAssertEqual(sut.minutes, 5)
        XCTAssertEqual(sut.seconds, 6)
    }
}

import CustomDump
import PeriodDuration
import XCTest

final class DateComponentsSupportTests: XCTestCase {
    let blankProps = Props()
    let zeroProps = Props(years: 0, months: 0, days: 0, hours: 0, minutes: 0, seconds: 0)
    let fullProps = Props(years: 1, months: 2, days: 3, hours: 4, minutes: 5, seconds: 6)

    func testPeriodDurationAsDateComponents() {
        XCTAssertNoDifference(
            PeriodDuration(blankProps).asDateComponents,
            DateComponents(blankProps)
        )
        XCTAssertNoDifference(
            PeriodDuration(zeroProps).asDateComponents,
            DateComponents(zeroProps)
        )
        XCTAssertNoDifference(
            PeriodDuration(fullProps).asDateComponents,
            DateComponents(fullProps)
        )
    }

    func testPeriodAsDateComponents() {
        XCTAssertNoDifference(
            Period(blankProps).asDateComponents,
            DateComponents(year: nil, month: nil, day: nil)
        )
        XCTAssertNoDifference(
            Period(zeroProps).asDateComponents,
            DateComponents(year: 0, month: 0, day: 0)
        )
        XCTAssertNoDifference(
            Period(fullProps).asDateComponents,
            DateComponents(year: 1, month: 2, day: 3)
        )
    }

    func testDurationAsDateComponents() {
        XCTAssertNoDifference(
            Duration(blankProps).asDateComponents,
            DateComponents(hour: nil, minute: nil, second: nil)
        )
        XCTAssertNoDifference(
            Duration(zeroProps).asDateComponents,
            DateComponents(hour: 0, minute: 0, second: 0)
        )
        XCTAssertNoDifference(
            Duration(fullProps).asDateComponents,
            DateComponents(hour: 4, minute: 5, second: 6)
        )
    }
}


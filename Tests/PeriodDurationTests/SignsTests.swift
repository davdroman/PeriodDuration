import PeriodDuration
import XCTest

final class SignsTests: XCTestCase {
    func testPeriodDurationSigns() {
        XCTAssertEqual(-PeriodDuration(blankProps), PeriodDuration(blankProps))
        XCTAssertEqual(-PeriodDuration(zeroProps), PeriodDuration(zeroProps))
        XCTAssertEqual(-PeriodDuration(fullProps), PeriodDuration(years: -1, months: -2, days: -3, hours: -4, minutes: -5, seconds: -6))
        XCTAssertEqual(-PeriodDuration(years: -1, months: -2, days: -3, hours: -4, minutes: -5, seconds: -6), PeriodDuration(fullProps))

        XCTAssertEqual(+PeriodDuration(blankProps), PeriodDuration(blankProps))
        XCTAssertEqual(+PeriodDuration(zeroProps), PeriodDuration(zeroProps))
        XCTAssertEqual(+PeriodDuration(fullProps), PeriodDuration(fullProps))
        XCTAssertEqual(+PeriodDuration(years: -1, months: -2, days: -3, hours: -4, minutes: -5, seconds: -6), PeriodDuration(years: -1, months: -2, days: -3, hours: -4, minutes: -5, seconds: -6))
    }

    func testPeriodSigns() {
        XCTAssertEqual(-Period(blankProps), Period(blankProps))
        XCTAssertEqual(-Period(zeroProps), Period(zeroProps))
        XCTAssertEqual(-Period(fullProps), Period(years: -1, months: -2, days: -3))
        XCTAssertEqual(-Period(years: -1, months: -2, days: -3), Period(fullProps))

        XCTAssertEqual(+Period(blankProps), Period(blankProps))
        XCTAssertEqual(+Period(zeroProps), Period(zeroProps))
        XCTAssertEqual(+Period(fullProps), Period(fullProps))
        XCTAssertEqual(+Period(years: -1, months: -2, days: -3), Period(years: -1, months: -2, days: -3))
    }

    func testDurationSigns() {
        XCTAssertEqual(-Duration(blankProps), Duration(blankProps))
        XCTAssertEqual(-Duration(zeroProps), Duration(zeroProps))
        XCTAssertEqual(-Duration(fullProps), Duration(hours: -4, minutes: -5, seconds: -6))
        XCTAssertEqual(-Duration(hours: -4, minutes: -5, seconds: -6), Duration(fullProps))

        XCTAssertEqual(+Duration(blankProps), Duration(blankProps))
        XCTAssertEqual(+Duration(zeroProps), Duration(zeroProps))
        XCTAssertEqual(+Duration(fullProps), Duration(fullProps))
        XCTAssertEqual(+Duration(hours: -4, minutes: -5, seconds: -6), Duration(hours: -4, minutes: -5, seconds: -6))
    }
}

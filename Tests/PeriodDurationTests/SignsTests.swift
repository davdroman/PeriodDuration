import PeriodDuration
import XCTest

final class SignsTests: XCTestCase {
    func testPeriodDurationSigns() {
        XCTAssertEqual(-PeriodDuration.zero, PeriodDuration.zero)
        XCTAssertEqual(-PeriodDuration(fullProps), PeriodDuration(years: -1, months: -2, days: -3, hours: -4, minutes: -5, seconds: -6))
        XCTAssertEqual(-PeriodDuration(years: -1, months: -2, days: -3, hours: -4, minutes: -5, seconds: -6), PeriodDuration(fullProps))

        XCTAssertEqual(+PeriodDuration.zero, PeriodDuration.zero)
        XCTAssertEqual(+PeriodDuration(fullProps), PeriodDuration(fullProps))
        XCTAssertEqual(+PeriodDuration(years: -1, months: -2, days: -3, hours: -4, minutes: -5, seconds: -6), PeriodDuration(years: -1, months: -2, days: -3, hours: -4, minutes: -5, seconds: -6))
    }

    func testPeriodSigns() {
        XCTAssertEqual(-Period.zero, Period.zero)
        XCTAssertEqual(-Period(fullProps), Period(years: -1, months: -2, days: -3))
        XCTAssertEqual(-Period(years: -1, months: -2, days: -3), Period(fullProps))

        XCTAssertEqual(+Period.zero, Period.zero)
        XCTAssertEqual(+Period(fullProps), Period(fullProps))
        XCTAssertEqual(+Period(years: -1, months: -2, days: -3), Period(years: -1, months: -2, days: -3))
    }

    func testDurationSigns() {
        XCTAssertEqual(-Duration.zero, Duration.zero)
        XCTAssertEqual(-Duration(fullProps), Duration(hours: -4, minutes: -5, seconds: -6))
        XCTAssertEqual(-Duration(hours: -4, minutes: -5, seconds: -6), Duration(fullProps))

        XCTAssertEqual(+Duration.zero, Duration.zero)
        XCTAssertEqual(+Duration(fullProps), Duration(fullProps))
        XCTAssertEqual(+Duration(hours: -4, minutes: -5, seconds: -6), Duration(hours: -4, minutes: -5, seconds: -6))
    }
}

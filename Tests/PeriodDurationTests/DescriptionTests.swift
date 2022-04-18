import PeriodDuration
import XCTest

final class DescriptionTests: XCTestCase {
    func testPeriodDurationDescription() {
        XCTAssertEqual(
            PeriodDuration.zero.description,
            ""
        )
        XCTAssertEqual(
            PeriodDuration(years: 1, months: 1, days: 1, hours: 1, minutes: 1, seconds: 1).description,
            "1 year, 1 month, 1 day, 1 hour, 1 minute, 1 second"
        )
        XCTAssertEqual(
            PeriodDuration(years: 3, months: 3, days: 3, hours: 3, minutes: 3, seconds: 3).description,
            "3 years, 3 months, 3 days, 3 hours, 3 minutes, 3 seconds"
        )
    }

    func testPeriodDescription() {
        XCTAssertEqual(
            Period.zero.description,
            ""
        )
        XCTAssertEqual(
            Period(years: 1, months: 1, days: 1).description,
            "1 year, 1 month, 1 day"
        )
        XCTAssertEqual(
            Period(years: 3, months: 3, days: 3).description,
            "3 years, 3 months, 3 days"
        )
    }

    func testDurationDescription() {
        XCTAssertEqual(
            Duration.zero.description,
            ""
        )
        XCTAssertEqual(
            Duration(hours: 1, minutes: 1, seconds: 1).description,
            "1 hour, 1 minute, 1 second"
        )
        XCTAssertEqual(
            Duration(hours: 3, minutes: 3, seconds: 3).description,
            "3 hours, 3 minutes, 3 seconds"
        )
    }
}

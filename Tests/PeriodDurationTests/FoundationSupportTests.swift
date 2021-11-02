import CustomDump
import PeriodDuration
import XCTest

final class FoundationSupportTests: XCTestCase {
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

    #if !os(Linux)
    func formatter(units: NSCalendar.Unit) -> DateComponentsFormatter {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = units
        formatter.unitsStyle = .full
        var calendar = Calendar(identifier: .iso8601)
        calendar.locale = Locale(identifier: "en_US_POSIX")
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        formatter.calendar = calendar
        return formatter
    }

    func testDateComponentsFormatter_stringFromPeriodDuration() {
        let formatter = formatter(units: [.year, .month, .day, .hour, .minute, .second])
        XCTAssertEqual(
            formatter.string(from: PeriodDuration(fullProps)),
            "1 year, 2 months, 3 days, 4 hours, 5 minutes, 6 seconds"
        )
        XCTAssertEqual(
            formatter.string(from: PeriodDuration(zeroProps)),
            "0 seconds"
        )
        XCTAssertEqual(
            formatter.string(from: PeriodDuration(blankProps)),
            nil
        )
    }

    func testDateComponentsFormatter_stringFromPeriod() {
        let formatter = formatter(units: [.year, .month, .day])
        XCTAssertEqual(
            formatter.string(from: Period(fullProps)),
            "1 year, 2 months, 3 days"
        )
        XCTAssertEqual(
            formatter.string(from: Period(zeroProps)),
            "0 days"
        )
        XCTAssertEqual(
            formatter.string(from: Period(blankProps)),
            nil
        )
    }

    func testDateComponentsFormatter_stringFromDuration() {
        let formatter = formatter(units: [.hour, .minute, .second])
        XCTAssertEqual(
            formatter.string(from: Duration(fullProps)),
            "4 hours, 5 minutes, 6 seconds"
        )
        XCTAssertEqual(
            formatter.string(from: Duration(zeroProps)),
            "0 seconds"
        )
        XCTAssertEqual(
            formatter.string(from: Duration(blankProps)),
            nil
        )
    }
    #endif
}

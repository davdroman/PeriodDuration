import PeriodDuration
import XCTest

final class IsBlankTests: XCTestCase {
    func testPeriodDurationIsBlank() {
        XCTAssertEqual(PeriodDuration(blankProps).isBlank, true)
        XCTAssertEqual(PeriodDuration(zeroProps).isBlank, false)
        XCTAssertEqual(PeriodDuration(fullProps).isBlank, false)
    }

    func testPeriodDurationIsBlankOrZero() {
        XCTAssertEqual(PeriodDuration(blankProps).isBlankOrZero, true)
        XCTAssertEqual(PeriodDuration(zeroProps).isBlankOrZero, true)
        XCTAssertEqual(PeriodDuration(fullProps).isBlankOrZero, false)
    }

    func testPeriodIsBlank() {
        XCTAssertEqual(Period(blankProps).isBlank, true)
        XCTAssertEqual(Period(zeroProps).isBlank, false)
        XCTAssertEqual(Period(fullProps).isBlank, false)
    }

    func testPeriodIsBlankOrZero() {
        XCTAssertEqual(Period(blankProps).isBlankOrZero, true)
        XCTAssertEqual(Period(zeroProps).isBlankOrZero, true)
        XCTAssertEqual(Period(fullProps).isBlankOrZero, false)
    }

    func testDurationIsBlank() {
        XCTAssertEqual(Duration(blankProps).isBlank, true)
        XCTAssertEqual(Duration(zeroProps).isBlank, false)
        XCTAssertEqual(Duration(fullProps).isBlank, false)
    }

    func testDurationIsBlankOrZero() {
        XCTAssertEqual(Duration(blankProps).isBlankOrZero, true)
        XCTAssertEqual(Duration(zeroProps).isBlankOrZero, true)
        XCTAssertEqual(Duration(fullProps).isBlankOrZero, false)
    }
}

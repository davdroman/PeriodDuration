import PeriodDuration
import XCTest

final class ZeroTests: XCTestCase {
    func testPeriodDurationZero() {
        let sut = PeriodDuration.zero
        XCTAssertEqual(sut.years, 0)
        XCTAssertEqual(sut.months, 0)
        XCTAssertEqual(sut.days, 0)
        XCTAssertEqual(sut.hours, 0)
        XCTAssertEqual(sut.minutes, 0)
        XCTAssertEqual(sut.seconds, 0)
    }

    func testPeriodZero() {
        let sut = Period.zero
        XCTAssertEqual(sut.years, 0)
        XCTAssertEqual(sut.months, 0)
        XCTAssertEqual(sut.days, 0)
    }

    func testDurationZero() {
        let sut = Duration.zero
        XCTAssertEqual(sut.hours, 0)
        XCTAssertEqual(sut.minutes, 0)
        XCTAssertEqual(sut.seconds, 0)
    }
}

import Period
import XCTest

final class PeriodTests: XCTestCase {
	func testInitWithAllComponents() {
		let period = Period(years: 1, months: 2, days: 3, hours: 4, minutes: 5, seconds: 6)
		XCTAssertEqual(period.years, 1)
		XCTAssertEqual(period.months, 2)
		XCTAssertEqual(period.days, 3)
		XCTAssertEqual(period.hours, 4)
		XCTAssertEqual(period.minutes, 5)
		XCTAssertEqual(period.seconds, 6)
	}

	func testInitWithDefaults() {
		let period = Period(years: 1)
		XCTAssertEqual(period.years, 1)
		XCTAssertEqual(period.months, 0)
		XCTAssertEqual(period.days, 0)
		XCTAssertEqual(period.hours, 0)
		XCTAssertEqual(period.minutes, 0)
		XCTAssertEqual(period.seconds, 0)
	}

	func testInitEmpty() {
		let period = Period()
		XCTAssertEqual(period, .zero)
	}

	func testZero() {
		let period = Period.zero
		XCTAssertEqual(period.years, 0)
		XCTAssertEqual(period.months, 0)
		XCTAssertEqual(period.days, 0)
		XCTAssertEqual(period.hours, 0)
		XCTAssertEqual(period.minutes, 0)
		XCTAssertEqual(period.seconds, 0)
	}
}

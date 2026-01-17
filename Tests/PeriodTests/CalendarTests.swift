import Foundation
import Period
import XCTest

final class CalendarTests: XCTestCase {
	let calendar = Calendar(identifier: .iso8601)

	func testCalendarDateByAddingPeriod() throws {
		let date = Date(timeIntervalSinceReferenceDate: 0) // 2001-01-01 00:00:00 UTC
		let period = Period(years: 1, months: 2, days: 3, hours: 4, minutes: 5, seconds: 6)

		let result = try XCTUnwrap(calendar.date(byAdding: period, to: date))

		let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: result)
		XCTAssertEqual(components.year, 2002)
		XCTAssertEqual(components.month, 3)
		XCTAssertEqual(components.day, 4)
		XCTAssertEqual(components.hour, 4)
		XCTAssertEqual(components.minute, 5)
		XCTAssertEqual(components.second, 6)
	}

	func testCalendarPeriodFromDates() throws {
		let start = Date(timeIntervalSinceReferenceDate: 0) // 2001-01-01 00:00:00 UTC
		let end = try XCTUnwrap(calendar.date(byAdding: DateComponents(year: 1, month: 2, day: 3, hour: 4, minute: 5, second: 6), to: start))

		let period = calendar.period(from: start, to: end)

		XCTAssertEqual(period.years, 1)
		XCTAssertEqual(period.months, 2)
		XCTAssertEqual(period.days, 3)
		XCTAssertEqual(period.hours, 4)
		XCTAssertEqual(period.minutes, 5)
		XCTAssertEqual(period.seconds, 6)
	}

	func testCalendarPeriodFromDatesNegative() throws {
		let start = Date(timeIntervalSinceReferenceDate: 0)
		let end = try XCTUnwrap(calendar.date(byAdding: DateComponents(year: -1, month: -2, day: -3), to: start))

		let period = calendar.period(from: start, to: end)

		XCTAssertEqual(period.years, -1)
		XCTAssertEqual(period.months, -2)
		XCTAssertEqual(period.days, -3)
	}
}

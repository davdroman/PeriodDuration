import Foundation
import Period
import Testing

struct CalendarTests {
	let calendar = Calendar(identifier: .iso8601)

	@Test func calendarDateByAddingPeriod() {
		let date = Date(timeIntervalSinceReferenceDate: 0) // 2001-01-01 00:00:00 UTC
		let period = Period(years: 1, months: 2, days: 3, hours: 4, minutes: 5, seconds: 6)

		let result = calendar.date(byAdding: period, to: date)

		#expect(result != nil)
		let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: result!)
		#expect(components.year == 2002)
		#expect(components.month == 3)
		#expect(components.day == 4)
		#expect(components.hour == 4)
		#expect(components.minute == 5)
		#expect(components.second == 6)
	}

	@Test func calendarPeriodFromDates() {
		let start = Date(timeIntervalSinceReferenceDate: 0) // 2001-01-01 00:00:00 UTC
		let end = calendar.date(byAdding: DateComponents(year: 1, month: 2, day: 3, hour: 4, minute: 5, second: 6), to: start)!

		let period = calendar.period(from: start, to: end)

		#expect(period.years == 1)
		#expect(period.months == 2)
		#expect(period.days == 3)
		#expect(period.hours == 4)
		#expect(period.minutes == 5)
		#expect(period.seconds == 6)
	}

	@Test func calendarPeriodFromDatesNegative() {
		let start = Date(timeIntervalSinceReferenceDate: 0)
		let end = calendar.date(byAdding: DateComponents(year: -1, month: -2, day: -3), to: start)!

		let period = calendar.period(from: start, to: end)

		#expect(period.years == -1)
		#expect(period.months == -2)
		#expect(period.days == -3)
	}
}

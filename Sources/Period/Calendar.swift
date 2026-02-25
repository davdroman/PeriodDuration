public import Foundation

extension Calendar {
	public func date(byAdding period: Period, to date: Date, wrappingComponents: Bool = false) -> Date? {
		self.date(byAdding: DateComponents(period), to: date, wrappingComponents: wrappingComponents)
	}

	public func period(from start: Date, to end: Date) -> Period {
		let components = dateComponents([.year, .month, .day, .hour, .minute, .second], from: start, to: end)
		return Period(
			years: components.year ?? 0,
			months: components.month ?? 0,
			days: components.day ?? 0,
			hours: components.hour ?? 0,
			minutes: components.minute ?? 0,
			seconds: components.second ?? 0,
		)
	}
}

extension DateComponents {
	init(_ period: Period) {
		self.init(
			year: period.years,
			month: period.months,
			day: period.days,
			hour: period.hours,
			minute: period.minutes,
			second: period.seconds,
		)
	}
}

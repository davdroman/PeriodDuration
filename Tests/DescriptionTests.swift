import Period
import Testing

struct DescriptionTests {
	@Test func periodDescription() {
		#expect(
			Period.zero.description
				== ""
		)
		#expect(
			Period(years: 1, months: 1, days: 1, hours: 1, minutes: 1, seconds: 1).description
				== "1 year, 1 month, 1 day, 1 hour, 1 minute, 1 second"
		)
		#expect(
			Period(years: 3, months: 3, days: 3, hours: 3, minutes: 3, seconds: 3).description
				== "3 years, 3 months, 3 days, 3 hours, 3 minutes, 3 seconds"
		)
	}
}

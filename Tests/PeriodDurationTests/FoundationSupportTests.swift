import CustomDump
import Foundation
import PeriodDuration
import Testing

struct FoundationSupportTests {
    @Test func periodDurationAsDateComponents() {
        expectNoDifference(
            PeriodDuration.zero.asDateComponents,
            DateComponents(zeroProps)
        )
        expectNoDifference(
            PeriodDuration(fullProps).asDateComponents,
            DateComponents(fullProps)
        )
    }

    @Test func periodAsDateComponents() {
        expectNoDifference(
            Period.zero.asDateComponents,
            DateComponents(year: 0, month: 0, day: 0)
        )
        expectNoDifference(
            Period(fullProps).asDateComponents,
            DateComponents(year: 1, month: 2, day: 3)
        )
    }

    @Test func durationAsDateComponents() {
        expectNoDifference(
            Duration.zero.asDateComponents,
            DateComponents(hour: 0, minute: 0, second: 0)
        )
        expectNoDifference(
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

    @Test func dateComponentsFormatter_stringFromPeriodDuration() {
        let formatter = formatter(units: [.year, .month, .day, .hour, .minute, .second])
        #expect(
            formatter.string(from: PeriodDuration(fullProps))
            == "1 year, 2 months, 3 days, 4 hours, 5 minutes, 6 seconds"
        )
        #expect(
            formatter.string(from: PeriodDuration.zero)
            == "0 seconds"
        )
    }

    @Test func dateComponentsFormatter_stringFromPeriod() {
        let formatter = formatter(units: [.year, .month, .day])
        #expect(
            formatter.string(from: Period(fullProps))
            == "1 year, 2 months, 3 days"
        )
        #expect(
            formatter.string(from: Period.zero)
            == "0 days"
        )
    }

    @Test func dateComponentsFormatter_stringFromDuration() {
        let formatter = formatter(units: [.hour, .minute, .second])
        #expect(
            formatter.string(from: Duration(fullProps))
            == "4 hours, 5 minutes, 6 seconds"
        )
        #expect(
            formatter.string(from: Duration.zero)
            == "0 seconds"
        )
    }
    #endif
}

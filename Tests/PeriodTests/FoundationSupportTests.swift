import CustomDump
import Foundation
import Period
import Testing

struct FoundationSupportTests {
    @Test func periodAsDateComponents() {
        expectNoDifference(
            Period.zero.asDateComponents,
            DateComponents(zeroProps)
        )
        expectNoDifference(
            Period(fullProps).asDateComponents,
            DateComponents(fullProps)
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

    @Test func dateComponentsFormatter_stringFromPeriod() {
        let formatter = formatter(units: [.year, .month, .day, .hour, .minute, .second])
        #expect(
            formatter.string(from: Period(fullProps))
            == "1 year, 2 months, 3 days, 4 hours, 5 minutes, 6 seconds"
        )
        #expect(
            formatter.string(from: Period.zero)
            == "0 seconds"
        )
    }
    #endif
}

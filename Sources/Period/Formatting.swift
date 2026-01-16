import Foundation

extension Period {
    public func formatted(
        style: DateComponentsFormatter.UnitsStyle = .full,
        allowedUnits: NSCalendar.Unit = [.year, .month, .day, .hour, .minute, .second],
        locale: Locale
    ) -> String {
        formatter.allowedUnits = allowedUnits
        formatter.unitsStyle = style
        formatter.calendar?.locale = locale
        return formatter.string(from: self) ?? ""
    }
}

fileprivate let formatter: DateComponentsFormatter = {
    var formatter = DateComponentsFormatter()
    var calendar = Calendar(identifier: .iso8601)
    calendar.timeZone = TimeZone(secondsFromGMT: 0)!
    formatter.calendar = calendar
    return formatter
}()

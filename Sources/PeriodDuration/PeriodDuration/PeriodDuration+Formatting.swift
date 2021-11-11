#if !os(Linux)
import Foundation

extension PeriodDuration {
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
#endif

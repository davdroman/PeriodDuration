#if !os(Linux)
import Foundation

extension Period {
    public func formatted(
        style: DateComponentsFormatter.UnitsStyle = .full,
        allowedUnits: NSCalendar.Unit = [.year, .month, .day],
        locale: Locale
    ) -> String {
        formatter.allowedUnits = allowedUnits
        formatter.unitsStyle = style
        formatter.calendar?.locale = locale
        return formatter.string(from: self) ?? ""
    }
}
#endif

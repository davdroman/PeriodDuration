#if !os(Linux)
import Foundation

extension Period {
    public func formatted(style: DateComponentsFormatter.UnitsStyle = .full, locale: Locale) -> String {
        formatter.allowedUnits = [.year, .month, .day]
        formatter.unitsStyle = style
        formatter.calendar?.locale = locale
        return formatter.string(from: self) ?? ""
    }
}
#endif

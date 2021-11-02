#if !os(Linux)
import Foundation

extension Duration {
    public func formatted(style: DateComponentsFormatter.UnitsStyle = .full, locale: Locale) -> String {
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = style
        formatter.calendar?.locale = locale
        return formatter.string(from: self) ?? ""
    }
}
#endif

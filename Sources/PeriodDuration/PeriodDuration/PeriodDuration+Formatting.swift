import Foundation

extension PeriodDuration {
    public func formatted(style: DateComponentsFormatter.UnitsStyle = .full, locale: Locale) -> String {
        formatter.allowedUnits = [.year, .month, .day, .hour, .minute, .second]
        formatter.unitsStyle = style
        formatter.calendar?.locale = locale
        return formatter.string(from: self) ?? ""
    }
}

import Foundation

extension Period {
    public var asDateComponents: DateComponents {
        DateComponents(
            year: years,
            month: months,
            day: days
        )
    }
}

#if !os(Linux)
extension DateComponentsFormatter {
    public func string(from period: Period) -> String? {
        string(from: period.asDateComponents)
    }
}
#endif

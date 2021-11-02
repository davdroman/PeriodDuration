import Foundation

extension PeriodDuration {
    public var isBlank: Bool {
        period.isBlank && duration.isBlank
    }

    public var isBlankOrZero: Bool {
        period.isBlankOrZero && duration.isBlankOrZero
    }
}

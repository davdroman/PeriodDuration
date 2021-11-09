#if DEBUG
import Foundation

extension PeriodDuration: ExpressibleByStringLiteral {
    public init(stringLiteral value: StringLiteralType) {
        guard let _self = Self(iso8601: value) else {
            preconditionFailure("Could not parse string literal '\(value)' into ISO 8601 PeriodDuration")
        }
        self = _self
    }
}
#endif

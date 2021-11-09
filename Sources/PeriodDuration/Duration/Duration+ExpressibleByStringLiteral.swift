#if DEBUG
import Foundation

extension Duration: ExpressibleByStringLiteral {
    public init(stringLiteral value: StringLiteralType) {
        guard let _self = Self(iso8601: value) else {
            preconditionFailure("Could not parse string literal '\(value)' into ISO 8601 Duration")
        }
        self = _self
    }
}
#endif

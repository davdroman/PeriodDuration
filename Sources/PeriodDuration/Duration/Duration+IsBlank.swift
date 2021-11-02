import Foundation

extension Duration {
    public var isBlank: Bool {
        [hours, minutes, seconds].compactMap { $0 }.isEmpty
    }

    public var isBlankOrZero: Bool {
        isBlank || [hours, minutes, seconds].allSatisfy(\.isNilOrZero)
    }
}

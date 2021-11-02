import Foundation

extension Period {
    public var isBlank: Bool {
        [years, months, days].compactMap { $0 }.isEmpty
    }

    public var isBlankOrZero: Bool {
        isBlank || [years, months, days].allSatisfy(\.isNilOrZero)
    }
}

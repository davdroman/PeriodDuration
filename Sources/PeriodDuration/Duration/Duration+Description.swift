import Foundation

extension Duration: CustomStringConvertible {
    public var description: String {
        [
            hours.nilIfZero.map { "\($0) hour\($0 == 1 ? "" : "s")" },
            minutes.nilIfZero.map { "\($0) minute\($0 == 1 ? "" : "s")" },
            seconds.nilIfZero.map { "\($0) second\($0 == 1 ? "" : "s")" },
        ]
        .lazy
        .compactMap { $0 }
        .joined(separator: ", ")
    }
}

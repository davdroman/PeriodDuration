import Foundation

extension Duration: CustomStringConvertible {
    public var description: String {
        [
            hours.map { "\($0) hour\($0 == 1 ? "" : "s")" },
            minutes.map { "\($0) minute\($0 == 1 ? "" : "s")" },
            seconds.map { "\($0) second\($0 == 1 ? "" : "s")" },
        ]
        .lazy
        .compactMap { $0 }
        .joined(separator: ", ")
    }
}

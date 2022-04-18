import Foundation

extension Period: CustomStringConvertible {
    public var description: String {
        [
            years.nilIfZero.map { "\($0) year\($0 == 1 ? "" : "s")" },
            months.nilIfZero.map { "\($0) month\($0 == 1 ? "" : "s")" },
            days.nilIfZero.map { "\($0) day\($0 == 1 ? "" : "s")" },
        ]
        .lazy
        .compactMap { $0 }
        .joined(separator: ", ")
    }
}

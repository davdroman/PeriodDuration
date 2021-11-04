import Foundation

extension Period: CustomStringConvertible {
    public var description: String {
        [
            years.map { "\($0) year\($0 == 1 ? "" : "s")" },
            months.map { "\($0) month\($0 == 1 ? "" : "s")" },
            days.map { "\($0) day\($0 == 1 ? "" : "s")" },
        ]
        .lazy
        .compactMap { $0 }
        .joined(separator: ", ")
    }
}

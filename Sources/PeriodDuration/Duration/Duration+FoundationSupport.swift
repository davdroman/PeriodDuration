import Foundation

extension Duration {
    public var asDateComponents: DateComponents {
        DateComponents(
            hour: hours,
            minute: minutes,
            second: seconds
        )
    }
}

#if !os(Linux)
extension DateComponentsFormatter {
    public func string(from duration: Duration) -> String? {
        string(from: duration.asDateComponents)
    }
}
#endif

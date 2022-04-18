import Foundation

public struct Duration: Hashable {
    public var hours: Int
    public var minutes: Int
    public var seconds: Int

    public init(hours: Int = 0, minutes: Int = 0, seconds: Int = 0) {
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
    }
}

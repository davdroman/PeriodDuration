import Foundation

public struct Duration: Hashable {
    public var hours: Int?
    public var minutes: Int?
    public var seconds: Int?

    public init(hours: Int? = nil, minutes: Int? = nil, seconds: Int? = nil) {
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
    }
}

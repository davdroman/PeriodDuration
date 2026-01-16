import Foundation

public struct Period: Hashable, Sendable {
    public var years: Int
    public var months: Int
    public var days: Int
    public var hours: Int
    public var minutes: Int
    public var seconds: Int

    public init(
        years: Int = 0,
        months: Int = 0,
        days: Int = 0,
        hours: Int = 0,
        minutes: Int = 0,
        seconds: Int = 0
    ) {
        self.years = years
        self.months = months
        self.days = days
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
    }
}

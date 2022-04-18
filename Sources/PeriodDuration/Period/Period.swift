import Foundation

public struct Period: Hashable {
    public var years: Int
    public var months: Int
    public var days: Int

    public init(years: Int = 0, months: Int = 0, days: Int = 0) {
        self.years = years
        self.months = months
        self.days = days
    }
}

import Foundation

public struct Period: Hashable {
    public var years: Int?
    public var months: Int?
    public var days: Int?

    public init(years: Int? = nil, months: Int? = nil, days: Int? = nil) {
        self.years = years
        self.months = months
        self.days = days
    }
}

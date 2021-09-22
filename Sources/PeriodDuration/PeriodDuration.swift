import Foundation

@dynamicMemberLookup
public struct PeriodDuration: Codable, Hashable {
    public var period: Period
    public var duration: Duration

    public init(period: Period, duration: Duration) {
        self.period = period
        self.duration = duration
    }

    public init(period: Period) {
        self.period = period
        self.duration = Duration()
    }

    public init(duration: Duration) {
        self.period = Period()
        self.duration = duration
    }

    public init(
        years: Int? = nil,
        months: Int? = nil,
        days: Int? = nil,
        hours: Int? = nil,
        minutes: Int? = nil,
        seconds: Int? = nil
    ) {
        self.init(
            period: Period(years: years, months: months, days: days),
            duration: Duration(hours: hours, minutes: minutes, seconds: seconds)
        )
    }
}

extension PeriodDuration {
    public subscript(dynamicMember keyPath: WritableKeyPath<Period, Int?>) -> Int? {
        get { period[keyPath: keyPath] }
        set { period[keyPath: keyPath] = newValue }
    }

    public subscript(dynamicMember keyPath: WritableKeyPath<Duration, Int?>) -> Int? {
        get { duration[keyPath: keyPath] }
        set { duration[keyPath: keyPath] = newValue }
    }
}

extension PeriodDuration {
    public var isBlank: Bool {
        period.isBlank && duration.isBlank
    }

    public var isBlankOrZero: Bool {
        period.isBlankOrZero && duration.isBlankOrZero
    }
}

extension PeriodDuration {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        guard let _self = Self(rawValue: rawValue) else {
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Invalid PeriodDuration rawValue \"\(rawValue)\""
            )
        }
        self = _self
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}

extension PeriodDuration {
    init?(rawValue: String) {
        guard
            let period = Period(rawValue: rawValue),
            let duration = Duration(rawValue: rawValue)
        else {
            return nil
        }
        self.init(period: period, duration: duration)
    }

    var rawValue: String {
        var result = ""
        result += "P"
        result += self.years.withSuffix("Y")
        result += self.months.withSuffix("M")
        result += self.days.withSuffix("D")

        guard !duration.isBlank else { return result }
        result += "T"
        result += self.hours.withSuffix("H")
        result += self.minutes.withSuffix("M")
        result += self.seconds.withSuffix("S")

        return result
    }
}

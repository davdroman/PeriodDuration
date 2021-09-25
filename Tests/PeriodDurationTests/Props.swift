import Foundation
import PeriodDuration

struct Props {
    var years: Int? = nil
    var months: Int? = nil
    var days: Int? = nil
    var hours: Int? = nil
    var minutes: Int? = nil
    var seconds: Int? = nil
}

extension PeriodDuration {
    init(_ props: Props) {
        self.init(
            years: props.years,
            months: props.months,
            days: props.days,
            hours: props.hours,
            minutes: props.minutes,
            seconds: props.seconds
        )
    }
}

extension Period {
    init(_ props: Props) {
        self.init(
            years: props.years,
            months: props.months,
            days: props.days
        )
    }
}

extension Duration {
    init(_ props: Props) {
        self.init(
            hours: props.hours,
            minutes: props.minutes,
            seconds: props.seconds
        )
    }
}

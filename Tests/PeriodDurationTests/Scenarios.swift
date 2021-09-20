import Foundation
import PeriodDuration

typealias Scenario = (String, Props?)

struct Props {
    var years: Int? = nil
    var months: Int? = nil
    var days: Int? = nil
    var hours: Int? = nil
    var minutes: Int? = nil
    var seconds: Int? = nil
}

extension PeriodDuration {
    init(props: Props) {
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
    init(props: Props) {
        self.init(
            years: props.years,
            months: props.months,
            days: props.days
        )
    }
}

extension Duration {
    init(props: Props) {
        self.init(
            hours: props.hours,
            minutes: props.minutes,
            seconds: props.seconds
        )
    }
}

let scenarios: [Scenario] = [
    // MARK: Full
    ("YMWDTHMS", nil),
    ("3YMWDTHMS", nil), // Y
    ("Y3MWDTHMS", nil), // M
    ("YM3WDTHMS", nil), // W
    ("YMW3DTHMS", nil), // D
    ("YMWDT3HMS", nil), // H
    ("YMWDTH3MS", nil), // m
    ("YMWDTHM3S", nil), // S
    ("3Y3M3W3DT3H3M3S", nil), // YMWDHMS

    ("PYMWDTHMS", .init()),
    ("P3YMWDTHMS", .init(years: 3)), // Y
    ("PY3MWDTHMS", .init(months: 3)), // M
    ("PYM3WDTHMS", .init(days: 21)), // W
    ("PYMW3DTHMS", .init(days: 3)), // D
    ("PYMWDT3HMS", .init(hours: 3)), // H
    ("PYMWDTH3MS", .init(minutes: 3)), // m
    ("PYMWDTHM3S", .init(seconds: 3)), // S
    ("P3Y3M3W3DT3H3M3S", .init(years: 3, months: 3, days: 24, hours: 3, minutes: 3, seconds: 3)), // YMWDHMS

    // MARK: Period Full
    ("YMWD", nil),
    ("3YMWD", nil), // Y
    ("Y3MWD", nil), // M
    ("YM3WD", nil), // W
    ("YMW3D", nil), // D
    ("3Y3MWD", nil), // YM
    ("YM3W3D", nil), // WD
    ("3YM3WD", nil), // YW
    ("3YMW3D", nil), // YD
    ("3Y3M3WD", nil), // YMW
    ("Y3M3W3D", nil), // MWD
    ("3Y3M3W3D", nil), // YMWD

    ("PYMWD", .init()),
    ("P3YMWD", .init(years: 3)), // Y
    ("PY3MWD", .init(months: 3)), // M
    ("PYM3WD", .init(days: 21)), // W
    ("PYMW3D", .init(days: 3)), // D
    ("P3Y3MWD", .init(years: 3, months: 3)), // YM
    ("PYM3W3D", .init(days: 24)), // WD
    ("P3YM3WD", .init(years: 3, days: 21)), // YW
    ("P3YMW3D", .init(years: 3, days: 3)), // YD
    ("P3Y3M3WD", .init(years: 3, months: 3, days: 21)), // YMW
    ("PY3M3W3D", .init(months: 3, days: 24)), // MWD
    ("P3Y3M3W3D", .init(years: 3, months: 3, days: 24)), // YMWD

    // MARK: Period Individual
    ("Y", nil),
    ("3Y", nil),

    ("PY", .init()),
    ("P3Y", .init(years: 3)),

    ("M", nil),
    ("3M", nil),

    ("PM", .init()),
    ("P3M", .init(months: 3)),

    ("W", nil),
    ("3W", nil),

    ("PW", .init()),
    ("P3W", .init(days: 21)),

    ("D", nil),
    ("3D", nil),

    ("PD", .init()),
    ("P3D", .init(days: 3)),

    // MARK: Duration Full
    ("THMS", nil),
    ("T3HMS", nil), // H
    ("TH3MS", nil), // M
    ("THM3S", nil), // S
    ("T3H3MS", nil), // HM
    ("TH3M3S", nil), // MS
    ("T3HM3S", nil), // HS
    ("T3H3M3S", nil), // HMS

    ("PTHMS", .init()),
    ("PT3HMS", .init(hours: 3)), // H
    ("PTH3MS", .init(minutes: 3)), // M
    ("PTHM3S", .init(seconds: 3)), // S
    ("PT3H3MS", .init(hours: 3, minutes: 3)), // HM
    ("PTH3M3S", .init(minutes: 3, seconds: 3)), // MS
    ("PT3HM3S", .init(hours: 3, seconds: 3)), // HS
    ("PT3H3M3S", .init(hours: 3, minutes: 3, seconds: 3)), // HMS

    // MARK: Duration Individual
    ("H", nil),
    ("TH", nil),
    ("3H", nil),
    ("T3H", nil),

    ("PTH", .init()),
    ("PT3H", .init(hours: 3)),

    ("M", nil),
    ("TM", nil),
    ("3M", nil),
    ("T3M", nil),

    ("PTM", .init()),
    ("PT3M", .init(minutes: 3)),

    ("S", nil),
    ("TS", nil),
    ("3S", nil),
    ("T3S", nil),

    ("PTS", .init()),
    ("PT3S", .init(seconds: 3)),

    // MARK: Edge Cases
    ("", nil),
    (" ", nil),
    ("3", nil),
    ("P3", nil),
    ("T3", nil),
    ("PT3", nil),
    ("*", nil),
    ("PT3H*", nil),
    ("PT3.0H", nil),
    ("PT3,2H", nil),
    ("PT32_H", nil),
    ("PT_32H", nil),
    ("PT 32H", nil),
    ("PT32 H", nil),
    (" PT32H", nil),
    ("PT32H ", nil),
    (" PT32H ", nil),
]

import Period

typealias Scenario = (input: String, output: Period?, identical: Bool)

let scenarios: [Scenario] = [
    // MARK: Full
    ("YMWDTHMS", nil, false),
    ("3YMWDTHMS", nil, false), // Y
    ("Y3MWDTHMS", nil, false), // M
    ("YM3WDTHMS", nil, false), // W
    ("YMW3DTHMS", nil, false), // D
    ("YMWDT3HMS", nil, false), // H
    ("YMWDTH3MS", nil, false), // m
    ("YMWDTHM3S", nil, false), // S
    ("3Y3M3W3DT3H3M3S", nil, false), // YMWDHMS

    ("PYMWDTHMS", nil, false),
    ("P3YMWDTHMS", Period(years: 3), false), // Y
    ("PY3MWDTHMS", Period(months: 3), false), // M
    ("PYM3WDTHMS", Period(days: 21), false), // W
    ("PYMW3DTHMS", Period(days: 3), false), // D
    ("PYMWDT3HMS", Period(hours: 3), false), // H
    ("PYMWDTH3MS", Period(minutes: 3), false), // m
    ("PYMWDTHM3S", Period(seconds: 3), false), // S
    ("P3Y3M3W3DT3H3M3S", Period(years: 3, months: 3, days: 24, hours: 3, minutes: 3, seconds: 3), false), // YMWDHMS
    ("P3Y3M3DT3H3M3S", Period(years: 3, months: 3, days: 3, hours: 3, minutes: 3, seconds: 3), true), // YMDHMS

    // MARK: Period Full
    ("YMWD", nil, false),
    ("3YMWD", nil, false), // Y
    ("Y3MWD", nil, false), // M
    ("YM3WD", nil, false), // W
    ("YMW3D", nil, false), // D
    ("3Y3MWD", nil, false), // YM
    ("YM3W3D", nil, false), // WD
    ("3YM3WD", nil, false), // YW
    ("3YMW3D", nil, false), // YD
    ("3Y3M3WD", nil, false), // YMW
    ("Y3M3W3D", nil, false), // MWD
    ("3Y3M3W3D", nil, false), // YMWD

    ("PYMWD", nil, false),
    ("P3YMWD", Period(years: 3), false), // Y
    ("PY3MWD", Period(months: 3), false), // M
    ("PYM3WD", Period(days: 21), false), // W
    ("PYMW3D", Period(days: 3), false), // D
    ("P3Y3MWD", Period(years: 3, months: 3), false), // YM
    ("PYM3W3D", Period(days: 24), false), // WD
    ("P3YM3WD", Period(years: 3, days: 21), false), // YW
    ("P3YMW3D", Period(years: 3, days: 3), false), // YD
    ("P3Y3M3WD", Period(years: 3, months: 3, days: 21), false), // YMW
    ("PY3M3W3D", Period(months: 3, days: 24), false), // MWD
    ("P3Y3M3W3D", Period(years: 3, months: 3, days: 24), false), // YMWD
    ("P3Y3M3D", Period(years: 3, months: 3, days: 3), true), // YMD

    // MARK: Period Individual
    ("Y", nil, false),
    ("3Y", nil, false),

    ("PY", nil, false),
    ("P3Y", Period(years: 3), false),

    ("M", nil, false),
    ("3M", nil, false),

    ("PM", nil, false),
    ("P3M", Period(months: 3), false),

    ("W", nil, false),
    ("3W", nil, false),

    ("PW", nil, false),
    ("P3W", Period(days: 21), false),

    ("D", nil, false),
    ("3D", nil, false),

    ("PD", nil, false),
    ("P3D", Period(days: 3), false),

    // MARK: Duration Full
    ("THMS", nil, false),
    ("T3HMS", nil, false), // H
    ("TH3MS", nil, false), // M
    ("THM3S", nil, false), // S
    ("T3H3MS", nil, false), // HM
    ("TH3M3S", nil, false), // MS
    ("T3HM3S", nil, false), // HS
    ("T3H3M3S", nil, false), // HMS

    ("PTHMS", nil, false),
    ("PT3HMS", Period(hours: 3), false), // H
    ("PTH3MS", Period(minutes: 3), false), // M
    ("PTHM3S", Period(seconds: 3), false), // S
    ("PT3H3MS", Period(hours: 3, minutes: 3), false), // HM
    ("PTH3M3S", Period(minutes: 3, seconds: 3), false), // MS
    ("PT3HM3S", Period(hours: 3, seconds: 3), false), // HS
    ("PT3H3M3S", Period(hours: 3, minutes: 3, seconds: 3), true), // HMS

    // MARK: Duration Individual
    ("H", nil, false),
    ("TH", nil, false),
    ("3H", nil, false),
    ("T3H", nil, false),

    ("PT", nil, false),
    ("PTH", nil, false),
    ("PT3H", Period(hours: 3), true),

    ("M", nil, false),
    ("TM", nil, false),
    ("3M", nil, false),
    ("T3M", nil, false),

    ("PTM", nil, false),
    ("PT3M", Period(minutes: 3), true),

    ("S", nil, false),
    ("TS", nil, false),
    ("3S", nil, false),
    ("T3S", nil, false),

    ("PTS", nil, false),
    ("PT3S", Period(seconds: 3), true),

    // MARK: Edge Cases
    ("", nil, false),
    (" ", nil, false),
    ("3", nil, false),
    ("P3", nil, false),
    ("P3 ", nil, false),
    ("P3  ", nil, false),
    ("T3", nil, false),
    ("PT3", nil, false),
    ("*", nil, false),
    ("PT3H*", nil, false),
    ("PT3.0H", nil, false),
    ("PT3,2H", nil, false),
    ("PT32_H", nil, false),
    ("PT_32H", nil, false),
    ("PT 32H", nil, false),
    ("PT32 H", nil, false),
    (" PT32H", nil, false),
    ("PT32H ", nil, false),
    (" PT32H ", nil, false),
]

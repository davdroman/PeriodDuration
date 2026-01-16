import Period

let scenarios: [Scenario] = [
    // MARK: Full
    .init("YMWDTHMS", nil),
    .init("3YMWDTHMS", nil), // Y
    .init("Y3MWDTHMS", nil), // M
    .init("YM3WDTHMS", nil), // W
    .init("YMW3DTHMS", nil), // D
    .init("YMWDT3HMS", nil), // H
    .init("YMWDTH3MS", nil), // m
    .init("YMWDTHM3S", nil), // S
    .init("3Y3M3W3DT3H3M3S", nil), // YMWDHMS

    .init("PYMWDTHMS", Period()),
    .init("P3YMWDTHMS", Period(years: 3)), // Y
    .init("PY3MWDTHMS", Period(months: 3)), // M
    .init("PYM3WDTHMS", Period(days: 21)), // W
    .init("PYMW3DTHMS", Period(days: 3)), // D
    .init("PYMWDT3HMS", Period(hours: 3)), // H
    .init("PYMWDTH3MS", Period(minutes: 3)), // m
    .init("PYMWDTHM3S", Period(seconds: 3)), // S
    .init("P3Y3M3W3DT3H3M3S", Period(years: 3, months: 3, days: 24, hours: 3, minutes: 3, seconds: 3)), // YMWDHMS
    .init("P3Y3M3DT3H3M3S", Period(years: 3, months: 3, days: 3, hours: 3, minutes: 3, seconds: 3), identical: true), // YMDHMS

    // MARK: Period Full
    .init("YMWD", nil),
    .init("3YMWD", nil), // Y
    .init("Y3MWD", nil), // M
    .init("YM3WD", nil), // W
    .init("YMW3D", nil), // D
    .init("3Y3MWD", nil), // YM
    .init("YM3W3D", nil), // WD
    .init("3YM3WD", nil), // YW
    .init("3YMW3D", nil), // YD
    .init("3Y3M3WD", nil), // YMW
    .init("Y3M3W3D", nil), // MWD
    .init("3Y3M3W3D", nil), // YMWD

    .init("PYMWD", Period()),
    .init("P3YMWD", Period(years: 3)), // Y
    .init("PY3MWD", Period(months: 3)), // M
    .init("PYM3WD", Period(days: 21)), // W
    .init("PYMW3D", Period(days: 3)), // D
    .init("P3Y3MWD", Period(years: 3, months: 3)), // YM
    .init("PYM3W3D", Period(days: 24)), // WD
    .init("P3YM3WD", Period(years: 3, days: 21)), // YW
    .init("P3YMW3D", Period(years: 3, days: 3)), // YD
    .init("P3Y3M3WD", Period(years: 3, months: 3, days: 21)), // YMW
    .init("PY3M3W3D", Period(months: 3, days: 24)), // MWD
    .init("P3Y3M3W3D", Period(years: 3, months: 3, days: 24)), // YMWD
    .init("P3Y3M3D", Period(years: 3, months: 3, days: 3), identical: true), // YMD

    // MARK: Period Individual
    .init("Y", nil),
    .init("3Y", nil),

    .init("PY", Period()),
    .init("P3Y", Period(years: 3)),

    .init("M", nil),
    .init("3M", nil),

    .init("PM", Period()),
    .init("P3M", Period(months: 3)),

    .init("W", nil),
    .init("3W", nil),

    .init("PW", Period()),
    .init("P3W", Period(days: 21)),

    .init("D", nil),
    .init("3D", nil),

    .init("PD", Period()),
    .init("P3D", Period(days: 3)),

    // MARK: Duration Full
    .init("THMS", nil),
    .init("T3HMS", nil), // H
    .init("TH3MS", nil), // M
    .init("THM3S", nil), // S
    .init("T3H3MS", nil), // HM
    .init("TH3M3S", nil), // MS
    .init("T3HM3S", nil), // HS
    .init("T3H3M3S", nil), // HMS

    .init("PTHMS", Period()),
    .init("PT3HMS", Period(hours: 3)), // H
    .init("PTH3MS", Period(minutes: 3)), // M
    .init("PTHM3S", Period(seconds: 3)), // S
    .init("PT3H3MS", Period(hours: 3, minutes: 3)), // HM
    .init("PTH3M3S", Period(minutes: 3, seconds: 3)), // MS
    .init("PT3HM3S", Period(hours: 3, seconds: 3)), // HS
    .init("PT3H3M3S", Period(hours: 3, minutes: 3, seconds: 3), identical: true), // HMS

    // MARK: Duration Individual
    .init("H", nil),
    .init("TH", nil),
    .init("3H", nil),
    .init("T3H", nil),

    .init("PT", Period()),
    .init("PTH", Period()),
    .init("PT3H", Period(hours: 3), identical: true),

    .init("M", nil),
    .init("TM", nil),
    .init("3M", nil),
    .init("T3M", nil),

    .init("PTM", Period()),
    .init("PT3M", Period(minutes: 3), identical: true),

    .init("S", nil),
    .init("TS", nil),
    .init("3S", nil),
    .init("T3S", nil),

    .init("PTS", Period()),
    .init("PT3S", Period(seconds: 3), identical: true),

    // MARK: Edge Cases
    .init("", nil),
    .init(" ", nil),
    .init("3", nil),
    .init("P3", nil),
    .init("P3 ", nil),
    .init("P3  ", nil),
    .init("T3", nil),
    .init("PT3", nil),
    .init("*", nil),
    .init("PT3H*", nil),
    .init("PT3.0H", nil),
    .init("PT3,2H", nil),
    .init("PT32_H", nil),
    .init("PT_32H", nil),
    .init("PT 32H", nil),
    .init("PT32 H", nil),
    .init(" PT32H", nil),
    .init("PT32H ", nil),
    .init(" PT32H ", nil),
]

struct Scenario: Sendable {
    /// Raw ISO 8601 input
    let input: String
    /// Expected Period parsed from input
    let output: Period?
    /// Whether input and output are exactly the same both ways (encoding & decoding)
    let identical: Bool

    init(_ input: String, _ output: Period?, identical: Bool = false) {
        self.input = input
        self.output = output
        self.identical = identical
    }
}

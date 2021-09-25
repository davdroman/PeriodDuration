import Foundation
import PeriodDuration
import XCTJSONKit

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

    .init("PYMWDTHMS", .init()),
    .init("P3YMWDTHMS", .init(years: 3)), // Y
    .init("PY3MWDTHMS", .init(months: 3)), // M
    .init("PYM3WDTHMS", .init(days: 21)), // W
    .init("PYMW3DTHMS", .init(days: 3)), // D
    .init("PYMWDT3HMS", .init(hours: 3)), // H
    .init("PYMWDTH3MS", .init(minutes: 3)), // m
    .init("PYMWDTHM3S", .init(seconds: 3)), // S
    .init("P3Y3M3W3DT3H3M3S", .init(years: 3, months: 3, days: 24, hours: 3, minutes: 3, seconds: 3)), // YMWDHMS
    .init("P3Y3M3DT3H3M3S", .init(years: 3, months: 3, days: 3, hours: 3, minutes: 3, seconds: 3), strictForType: PeriodDuration.self), // YMDHMS

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

    .init("PYMWD", .init()),
    .init("P3YMWD", .init(years: 3)), // Y
    .init("PY3MWD", .init(months: 3)), // M
    .init("PYM3WD", .init(days: 21)), // W
    .init("PYMW3D", .init(days: 3)), // D
    .init("P3Y3MWD", .init(years: 3, months: 3)), // YM
    .init("PYM3W3D", .init(days: 24)), // WD
    .init("P3YM3WD", .init(years: 3, days: 21)), // YW
    .init("P3YMW3D", .init(years: 3, days: 3)), // YD
    .init("P3Y3M3WD", .init(years: 3, months: 3, days: 21)), // YMW
    .init("PY3M3W3D", .init(months: 3, days: 24)), // MWD
    .init("P3Y3M3W3D", .init(years: 3, months: 3, days: 24)), // YMWD
    .init("P3Y3M3D", .init(years: 3, months: 3, days: 3), strictForType: Period.self), // YMD

    // MARK: Period Individual
    .init("Y", nil),
    .init("3Y", nil),

    .init("PY", .init()),
    .init("P3Y", .init(years: 3)),

    .init("M", nil),
    .init("3M", nil),

    .init("PM", .init()),
    .init("P3M", .init(months: 3)),

    .init("W", nil),
    .init("3W", nil),

    .init("PW", .init()),
    .init("P3W", .init(days: 21)),

    .init("D", nil),
    .init("3D", nil),

    .init("PD", .init()),
    .init("P3D", .init(days: 3)),

    // MARK: Duration Full
    .init("THMS", nil),
    .init("T3HMS", nil), // H
    .init("TH3MS", nil), // M
    .init("THM3S", nil), // S
    .init("T3H3MS", nil), // HM
    .init("TH3M3S", nil), // MS
    .init("T3HM3S", nil), // HS
    .init("T3H3M3S", nil), // HMS

    .init("PTHMS", .init()),
    .init("PT3HMS", .init(hours: 3)), // H
    .init("PTH3MS", .init(minutes: 3)), // M
    .init("PTHM3S", .init(seconds: 3)), // S
    .init("PT3H3MS", .init(hours: 3, minutes: 3)), // HM
    .init("PTH3M3S", .init(minutes: 3, seconds: 3)), // MS
    .init("PT3HM3S", .init(hours: 3, seconds: 3)), // HS
    .init("PT3H3M3S", .init(hours: 3, minutes: 3, seconds: 3), strictForType: Duration.self), // HMS

    // MARK: Duration Individual
    .init("H", nil),
    .init("TH", nil),
    .init("3H", nil),
    .init("T3H", nil),

    .init("PT", .init(), strictForType: Duration.self),
    .init("PTH", .init()),
    .init("PT3H", .init(hours: 3), strictForType: Duration.self),

    .init("M", nil),
    .init("TM", nil),
    .init("3M", nil),
    .init("T3M", nil),

    .init("PTM", .init()),
    .init("PT3M", .init(minutes: 3), strictForType: Duration.self),

    .init("S", nil),
    .init("TS", nil),
    .init("3S", nil),
    .init("T3S", nil),

    .init("PTS", .init()),
    .init("PT3S", .init(seconds: 3), strictForType: Duration.self),

    // MARK: Edge Cases
    .init("", nil),
    .init(" ", nil),
    .init("3", nil),
    .init("P3", nil),
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

struct Scenario {
    typealias Input = JSON
    typealias Output = Props

    /// Raw ISO 8601 input
    let input: Input
    /// Expected props computed from input
    let output: Output?
    /// A type for which the input and output is exactly the same both ways (encoding & decoding)
    let strictForType: Any.Type?

    init(_ input: Input, _ output: Output?, strictForType: Any.Type? = nil) {
        self.input = input
        self.output = output
        self.strictForType = strictForType
    }
}

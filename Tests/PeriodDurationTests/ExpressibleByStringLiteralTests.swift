import PeriodDuration
import Testing

struct ExpressibleByStringLiteralTests {
    @Test func periodDuration() {
        #expect("PYMWDTHMS" == PeriodDuration())
        #expect("P3YMWDTHMS" == PeriodDuration(years: 3)) // Y
        #expect("PY3MWDTHMS" == PeriodDuration(months: 3)) // M
        #expect("PYM3WDTHMS" == PeriodDuration(days: 21)) // W
        #expect("PYMW3DTHMS" == PeriodDuration(days: 3)) // D
        #expect("PYMWDT3HMS" == PeriodDuration(hours: 3)) // H
        #expect("PYMWDTH3MS" == PeriodDuration(minutes: 3)) // m
        #expect("PYMWDTHM3S" == PeriodDuration(seconds: 3)) // S
        #expect("P3Y3M3W3DT3H3M3S" == PeriodDuration(years: 3, months: 3, days: 24, hours: 3, minutes: 3, seconds: 3)) // YMWDHMS
        #expect("P3Y3M3DT3H3M3S" == PeriodDuration(years: 3, months: 3, days: 3, hours: 3, minutes: 3, seconds: 3)) // YMDHMS
    }

    @Test func period() {
        #expect("PYMWD" == Period())
        #expect("P3YMWD" == Period(years: 3)) // Y
        #expect("PY3MWD" == Period(months: 3)) // M
        #expect("PYM3WD" == Period(days: 21)) // W
        #expect("PYMW3D" == Period(days: 3)) // D
        #expect("P3Y3MWD" == Period(years: 3, months: 3)) // YM
        #expect("PYM3W3D" == Period(days: 24)) // WD
        #expect("P3YM3WD" == Period(years: 3, days: 21)) // YW
        #expect("P3YMW3D" == Period(years: 3, days: 3)) // YD
        #expect("P3Y3M3WD" == Period(years: 3, months: 3, days: 21)) // YMW
        #expect("PY3M3W3D" == Period(months: 3, days: 24)) // MWD
        #expect("P3Y3M3W3D" == Period(years: 3, months: 3, days: 24)) // YMWD
        #expect("P3Y3M3D" == Period(years: 3, months: 3, days: 3)) // YMD

        #expect("PY" == Period())
        #expect("P3Y" == Period(years: 3))

        #expect("PM" == Period())
        #expect("P3M" == Period(months: 3))

        #expect("PW" == Period())
        #expect("P3W" == Period(days: 21))

        #expect("PD" == Period())
        #expect("P3D" == Period(days: 3))
    }

    @Test func duration() {
        #expect("PTHMS" == Duration())
        #expect("PT3HMS" == Duration(hours: 3)) // H
        #expect("PTH3MS" == Duration(minutes: 3)) // M
        #expect("PTHM3S" == Duration(seconds: 3)) // S
        #expect("PT3H3MS" == Duration(hours: 3, minutes: 3)) // HM
        #expect("PTH3M3S" == Duration(minutes: 3, seconds: 3)) // MS
        #expect("PT3HM3S" == Duration(hours: 3, seconds: 3)) // HS
        #expect("PT3H3M3S" == Duration(hours: 3, minutes: 3, seconds: 3)) // HMS

        #expect("PT" == Duration())
        #expect("PTH" == Duration())
        #expect("PT3H" == Duration(hours: 3))

        #expect("PTM" == Duration())
        #expect("PT3M" == Duration(minutes: 3))

        #expect("PTS" == Duration())
        #expect("PT3S" == Duration(seconds: 3))
    }
}

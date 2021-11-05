import PeriodDuration
import XCTest

final class ExpressibleByStringLiteralTests: XCTestCase {
    func testPeriodDuration() {
        XCTAssertEqual("PYMWDTHMS", PeriodDuration())
        XCTAssertEqual("P3YMWDTHMS", PeriodDuration(years: 3)) // Y
        XCTAssertEqual("PY3MWDTHMS", PeriodDuration(months: 3)) // M
        XCTAssertEqual("PYM3WDTHMS", PeriodDuration(days: 21)) // W
        XCTAssertEqual("PYMW3DTHMS", PeriodDuration(days: 3)) // D
        XCTAssertEqual("PYMWDT3HMS", PeriodDuration(hours: 3)) // H
        XCTAssertEqual("PYMWDTH3MS", PeriodDuration(minutes: 3)) // m
        XCTAssertEqual("PYMWDTHM3S", PeriodDuration(seconds: 3)) // S
        XCTAssertEqual("P3Y3M3W3DT3H3M3S", PeriodDuration(years: 3, months: 3, days: 24, hours: 3, minutes: 3, seconds: 3)) // YMWDHMS
        XCTAssertEqual("P3Y3M3DT3H3M3S", PeriodDuration(years: 3, months: 3, days: 3, hours: 3, minutes: 3, seconds: 3)) // YMDHMS
    }

    func testPeriod() {
        XCTAssertEqual("PYMWD", Period())
        XCTAssertEqual("P3YMWD", Period(years: 3)) // Y
        XCTAssertEqual("PY3MWD", Period(months: 3)) // M
        XCTAssertEqual("PYM3WD", Period(days: 21)) // W
        XCTAssertEqual("PYMW3D", Period(days: 3)) // D
        XCTAssertEqual("P3Y3MWD", Period(years: 3, months: 3)) // YM
        XCTAssertEqual("PYM3W3D", Period(days: 24)) // WD
        XCTAssertEqual("P3YM3WD", Period(years: 3, days: 21)) // YW
        XCTAssertEqual("P3YMW3D", Period(years: 3, days: 3)) // YD
        XCTAssertEqual("P3Y3M3WD", Period(years: 3, months: 3, days: 21)) // YMW
        XCTAssertEqual("PY3M3W3D", Period(months: 3, days: 24)) // MWD
        XCTAssertEqual("P3Y3M3W3D", Period(years: 3, months: 3, days: 24)) // YMWD
        XCTAssertEqual("P3Y3M3D", Period(years: 3, months: 3, days: 3)) // YMD

        XCTAssertEqual("PY", Period())
        XCTAssertEqual("P3Y", Period(years: 3))

        XCTAssertEqual("PM", Period())
        XCTAssertEqual("P3M", Period(months: 3))

        XCTAssertEqual("PW", Period())
        XCTAssertEqual("P3W", Period(days: 21))

        XCTAssertEqual("PD", Period())
        XCTAssertEqual("P3D", Period(days: 3))
    }

    func testDuration() {
        XCTAssertEqual("PTHMS", Duration())
        XCTAssertEqual("PT3HMS", Duration(hours: 3)) // H
        XCTAssertEqual("PTH3MS", Duration(minutes: 3)) // M
        XCTAssertEqual("PTHM3S", Duration(seconds: 3)) // S
        XCTAssertEqual("PT3H3MS", Duration(hours: 3, minutes: 3)) // HM
        XCTAssertEqual("PTH3M3S", Duration(minutes: 3, seconds: 3)) // MS
        XCTAssertEqual("PT3HM3S", Duration(hours: 3, seconds: 3)) // HS
        XCTAssertEqual("PT3H3M3S", Duration(hours: 3, minutes: 3, seconds: 3)) // HMS

        XCTAssertEqual("PT", Duration())
        XCTAssertEqual("PTH", Duration())
        XCTAssertEqual("PT3H", Duration(hours: 3))

        XCTAssertEqual("PTM", Duration())
        XCTAssertEqual("PT3M", Duration(minutes: 3))

        XCTAssertEqual("PTS", Duration())
        XCTAssertEqual("PT3S", Duration(seconds: 3))
    }
}

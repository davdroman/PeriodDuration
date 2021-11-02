import PeriodDuration
import XCTest

final class FormattingTests: XCTestCase {
    let enLocale = Locale(identifier: "en_GB")
    let esLocale = Locale(identifier: "es_ES")
}

extension FormattingTests {
    func testPeriodDurationFormatting_defaultStyle_enLocale() {
        XCTAssertEqual(
            PeriodDuration(blankProps).formatted(locale: enLocale),
            ""
        )
        XCTAssertEqual(
            PeriodDuration(zeroProps).formatted(locale: enLocale),
            "0 seconds"
        )
        XCTAssertEqual(
            PeriodDuration(fullProps).formatted(locale: enLocale),
            "1 year, 2 months, 3 days, 4 hours, 5 minutes, 6 seconds"
        )
    }

    func testPeriodFormatting_defaultStyle_enLocale() {
        XCTAssertEqual(
            Period(blankProps).formatted(locale: enLocale),
            ""
        )
        XCTAssertEqual(
            Period(zeroProps).formatted(locale: enLocale),
            "0 days"
        )
        XCTAssertEqual(
            Period(fullProps).formatted(locale: enLocale),
            "1 year, 2 months, 3 days"
        )
    }

    func testDurationFormatting_defaultStyle_enLocale() {
        XCTAssertEqual(
            Duration(blankProps).formatted(locale: enLocale),
            ""
        )
        XCTAssertEqual(
            Duration(zeroProps).formatted(locale: enLocale),
            "0 seconds"
        )
        XCTAssertEqual(
            Duration(fullProps).formatted(locale: enLocale),
            "4 hours, 5 minutes, 6 seconds"
        )
    }
}

extension FormattingTests {
    func testPeriodDurationFormatting_explicitStyle_enLocale() {
        XCTAssertEqual(
            PeriodDuration(blankProps).formatted(style: .short, locale: enLocale),
            ""
        )
        XCTAssertEqual(
            PeriodDuration(zeroProps).formatted(style: .short, locale: enLocale),
            "0 secs"
        )
        XCTAssertEqual(
            PeriodDuration(fullProps).formatted(style: .short, locale: enLocale),
            "1 yr, 2 mths, 3 days, 4 hrs, 5 min, 6 secs"
        )
    }

    func testPeriodFormatting_explicitStyle_enLocale() {
        XCTAssertEqual(
            Period(blankProps).formatted(style: .short, locale: enLocale),
            ""
        )
        XCTAssertEqual(
            Period(zeroProps).formatted(style: .short, locale: enLocale),
            "0 days"
        )
        XCTAssertEqual(
            Period(fullProps).formatted(style: .short, locale: enLocale),
            "1 yr, 2 mths, 3 days"
        )
    }

    func testDurationFormatting_explicitStyle_enLocale() {
        XCTAssertEqual(
            Duration(blankProps).formatted(style: .short, locale: enLocale),
            ""
        )
        XCTAssertEqual(
            Duration(zeroProps).formatted(style: .short, locale: enLocale),
            "0 secs"
        )
        XCTAssertEqual(
            Duration(fullProps).formatted(style: .short, locale: enLocale),
            "4 hrs, 5 min, 6 secs"
        )
    }
}

extension FormattingTests {
    func testPeriodDurationFormatting_defaultStyle_esLocale() {
        XCTAssertEqual(
            PeriodDuration(blankProps).formatted(locale: esLocale),
            ""
        )
        XCTAssertEqual(
            PeriodDuration(zeroProps).formatted(locale: esLocale),
            "0 segundos"
        )
        XCTAssertEqual(
            PeriodDuration(fullProps).formatted(locale: esLocale),
            "1 año, 2 meses, 3 días, 4 horas, 5 minutos y 6 segundos"
        )
    }

    func testPeriodFormatting_defaultStyle_esLocale() {
        XCTAssertEqual(
            Period(blankProps).formatted(locale: esLocale),
            ""
        )
        XCTAssertEqual(
            Period(zeroProps).formatted(locale: esLocale),
            "0 días"
        )
        XCTAssertEqual(
            Period(fullProps).formatted(locale: esLocale),
            "1 año, 2 meses y 3 días"
        )
    }

    func testDurationFormatting_defaultStyle_esLocale() {
        XCTAssertEqual(
            Duration(blankProps).formatted(locale: esLocale),
            ""
        )
        XCTAssertEqual(
            Duration(zeroProps).formatted(locale: esLocale),
            "0 segundos"
        )
        XCTAssertEqual(
            Duration(fullProps).formatted(locale: esLocale),
            "4 horas, 5 minutos y 6 segundos"
        )
    }
}

extension FormattingTests {
    func testPeriodDurationFormatting_explicitStyle_esLocale() {
        XCTAssertEqual(
            PeriodDuration(blankProps).formatted(style: .short, locale: esLocale),
            ""
        )
        XCTAssertEqual(
            PeriodDuration(zeroProps).formatted(style: .short, locale: esLocale),
            "0 s"
        )
        XCTAssertEqual(
            PeriodDuration(fullProps).formatted(style: .short, locale: esLocale),
            "1 a, 2 m., 3 d, 4 h, 5 min, 6 s"
        )
    }

    func testPeriodFormatting_explicitStyle_esLocale() {
        XCTAssertEqual(
            Period(blankProps).formatted(style: .short, locale: esLocale),
            ""
        )
        XCTAssertEqual(
            Period(zeroProps).formatted(style: .short, locale: esLocale),
            "0 d"
        )
        XCTAssertEqual(
            Period(fullProps).formatted(style: .short, locale: esLocale),
            "1 a, 2 m., 3 d"
        )
    }

    func testDurationFormatting_explicitStyle_esLocale() {
        XCTAssertEqual(
            Duration(blankProps).formatted(style: .short, locale: esLocale),
            ""
        )
        XCTAssertEqual(
            Duration(zeroProps).formatted(style: .short, locale: esLocale),
            "0 s"
        )
        XCTAssertEqual(
            Duration(fullProps).formatted(style: .short, locale: esLocale),
            "4 h, 5 min, 6 s"
        )
    }
}

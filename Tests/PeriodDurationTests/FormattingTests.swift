#if !os(Linux)
import PeriodDuration
import XCTest

final class FormattingTests: XCTestCase {
    let enLocale = Locale(identifier: "en_GB")
    let esLocale = Locale(identifier: "es_ES")
}

extension FormattingTests {
    func testPeriodDurationFormatting_defaultStyle() {
        XCTAssertEqual(
            PeriodDuration.zero.formatted(locale: enLocale),
            "0 seconds"
        )
        XCTAssertEqual(
            PeriodDuration(fullProps).formatted(locale: enLocale),
            "1 year, 2 months, 3 days, 4 hours, 5 minutes, 6 seconds"
        )
    }

    func testPeriodFormatting_defaultStyle() {
        XCTAssertEqual(
            Period.zero.formatted(locale: enLocale),
            "0 days"
        )
        XCTAssertEqual(
            Period(fullProps).formatted(locale: enLocale),
            "1 year, 2 months, 3 days"
        )
    }

    func testDurationFormatting_defaultStyle() {
        XCTAssertEqual(
            Duration.zero.formatted(locale: enLocale),
            "0 seconds"
        )
        XCTAssertEqual(
            Duration(fullProps).formatted(locale: enLocale),
            "4 hours, 5 minutes, 6 seconds"
        )
    }
}

extension FormattingTests {
    func testPeriodDurationFormatting_explicitStyle() {
        XCTAssertEqual(
            PeriodDuration.zero.formatted(style: .short, locale: enLocale),
            "0 secs"
        )
        XCTAssertEqual(
            PeriodDuration(fullProps).formatted(style: .short, locale: enLocale),
            "1 yr, 2 mths, 3 days, 4 hrs, 5 min, 6 secs"
        )
    }

    func testPeriodFormatting_explicitStyle() {
        XCTAssertEqual(
            Period.zero.formatted(style: .short, locale: enLocale),
            "0 days"
        )
        XCTAssertEqual(
            Period(fullProps).formatted(style: .short, locale: enLocale),
            "1 yr, 2 mths, 3 days"
        )
    }

    func testDurationFormatting_explicitStyle() {
        XCTAssertEqual(
            Duration.zero.formatted(style: .short, locale: enLocale),
            "0 secs"
        )
        XCTAssertEqual(
            Duration(fullProps).formatted(style: .short, locale: enLocale),
            "4 hrs, 5 min, 6 secs"
        )
    }
}

extension FormattingTests {
    func testPeriodDurationFormatting_customAllowedUnits() {
        XCTAssertEqual(
            PeriodDuration.zero.formatted(allowedUnits: [.day, .hour, .minute, .second], locale: enLocale),
            "0 seconds"
        )
        XCTAssertEqual(
            PeriodDuration(fullProps).formatted(allowedUnits: [.day, .hour, .minute, .second], locale: enLocale),
            "427 days, 4 hours, 5 minutes, 6 seconds"
        )
    }

    func testPeriodFormatting_customAllowedUnits() {
        XCTAssertEqual(
            Period.zero.formatted(allowedUnits: [.day, .hour, .minute, .second], locale: enLocale),
            "0 seconds"
        )
        XCTAssertEqual(
            Period(fullProps).formatted(allowedUnits: [.month, .minute], locale: enLocale),
            "14 months, 4,320 minutes"
        )
    }

    func testDurationFormatting_customAllowedUnits() {
        XCTAssertEqual(
            Duration.zero.formatted(allowedUnits: [.hour, .minute], locale: enLocale),
            "0 minutes"
        )
        XCTAssertEqual(
            Duration(fullProps).formatted(allowedUnits: [.hour, .minute], locale: enLocale),
            "4 hours, 5 minutes"
        )
    }
}

extension FormattingTests {
    func testPeriodDurationFormatting_esLocale() {
        XCTAssertEqual(
            PeriodDuration.zero.formatted(locale: esLocale),
            "0 segundos"
        )
        XCTAssertEqual(
            PeriodDuration(fullProps).formatted(locale: esLocale),
            "1 año, 2 meses, 3 días, 4 horas, 5 minutos y 6 segundos"
        )
    }

    func testPeriodFormatting_esLocale() {
        XCTAssertEqual(
            Period.zero.formatted(locale: esLocale),
            "0 días"
        )
        XCTAssertEqual(
            Period(fullProps).formatted(locale: esLocale),
            "1 año, 2 meses y 3 días"
        )
    }

    func testDurationFormatting_esLocale() {
        XCTAssertEqual(
            Duration.zero.formatted(locale: esLocale),
            "0 segundos"
        )
        XCTAssertEqual(
            Duration(fullProps).formatted(locale: esLocale),
            "4 horas, 5 minutos y 6 segundos"
        )
    }
}
#endif

#if !os(Linux)
import Foundation
import Period
import Testing

struct FormattingTests {
    let enLocale = Locale(identifier: "en_GB")
    let esLocale = Locale(identifier: "es_ES")
}

extension FormattingTests {
    @Test func periodFormatting_defaultStyle() {
        #expect(
            Period.zero.formatted(locale: enLocale)
            == "0 seconds"
        )
        #expect(
            Period(fullProps).formatted(locale: enLocale)
            == "1 year, 2 months, 3 days, 4 hours, 5 minutes, 6 seconds"
        )
    }
}

extension FormattingTests {
    @Test func periodFormatting_explicitStyle() {
        #expect(
            Period.zero.formatted(style: .short, locale: enLocale)
            == "0 secs"
        )
        #expect(
            Period(fullProps).formatted(style: .short, locale: enLocale)
            == "1 yr, 2 mths, 3 days, 4 hrs, 5 min, 6 secs"
        )
    }
}

extension FormattingTests {
    @Test func periodFormatting_customAllowedUnits() {
        #expect(
            Period.zero.formatted(allowedUnits: [.day, .hour, .minute, .second], locale: enLocale)
            == "0 seconds"
        )
        #expect(
            Period(fullProps).formatted(allowedUnits: [.day, .hour, .minute, .second], locale: enLocale)
            == "427 days, 4 hours, 5 minutes, 6 seconds"
        )
    }
}

extension FormattingTests {
    @Test func periodFormatting_esLocale() {
        let zeroResult = Period.zero.formatted(locale: esLocale)
        #expect(zeroResult.contains("0"))

        let fullResult = Period(fullProps).formatted(locale: esLocale)
        #expect(fullResult.contains("1"))
        #expect(fullResult.contains("2"))
        #expect(fullResult.contains("3"))
        #expect(fullResult.contains("4"))
        #expect(fullResult.contains("5"))
        #expect(fullResult.contains("6"))
    }
}
#endif

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
            Period.zero.formatted(.full.locale(enLocale))
            == "0 seconds"
        )
        #expect(
            Period(fullProps).formatted(.full.locale(enLocale))
            == "1 year, 2 months, 3 days, 4 hours, 5 minutes, 6 seconds"
        )
    }
}

extension FormattingTests {
    @Test func periodFormatting_explicitStyle() {
        #expect(
            Period.zero.formatted(.short.locale(enLocale))
            == "0 secs"
        )
        #expect(
            Period(fullProps).formatted(.short.locale(enLocale))
            == "1 yr, 2 mths, 3 days, 4 hrs, 5 min, 6 secs"
        )
    }
}

extension FormattingTests {
    @Test func periodFormatting_customAllowedUnits() {
        #expect(
            Period.zero.formatted(.full.allowedUnits([.day, .hour, .minute, .second]).locale(enLocale))
            == "0 seconds"
        )
        #expect(
            Period(fullProps).formatted(.full.allowedUnits([.day, .hour, .minute, .second]).locale(enLocale))
            == "427 days, 4 hours, 5 minutes, 6 seconds"
        )
    }
}

extension FormattingTests {
    @Test func periodFormatting_esLocale() {
        #expect(
            Period.zero.formatted(.full.locale(esLocale))
            == "0 segundos"
        )
        #expect(
            Period(fullProps).formatted(.full.locale(esLocale))
            == "1 año, 2 meses, 3 días, 4 horas, 5 minutos y 6 segundos"
        )
    }
}
#endif

#if !os(Linux)
import PeriodDuration
import Testing

struct FormattingTests {
    let enLocale = Locale(identifier: "en_GB")
    let esLocale = Locale(identifier: "es_ES")
}

extension FormattingTests {
    @Test func periodDurationFormatting_defaultStyle() {
        #expect(
            PeriodDuration.zero.formatted(locale: enLocale)
            == "0 seconds"
        )
        #expect(
            PeriodDuration(fullProps).formatted(locale: enLocale)
            == "1 year, 2 months, 3 days, 4 hours, 5 minutes, 6 seconds"
        )
    }

    @Test func periodFormatting_defaultStyle() {
        #expect(
            Period.zero.formatted(locale: enLocale)
            == "0 days"
        )
        #expect(
            Period(fullProps).formatted(locale: enLocale)
            == "1 year, 2 months, 3 days"
        )
    }

    @Test func durationFormatting_defaultStyle() {
        #expect(
            Duration.zero.formatted(locale: enLocale)
            == "0 seconds"
        )
        #expect(
            Duration(fullProps).formatted(locale: enLocale)
            == "4 hours, 5 minutes, 6 seconds"
        )
    }
}

extension FormattingTests {
    @Test func periodDurationFormatting_explicitStyle() {
        #expect(
            PeriodDuration.zero.formatted(style: .short, locale: enLocale)
            == "0 secs"
        )
        #expect(
            PeriodDuration(fullProps).formatted(style: .short, locale: enLocale)
            == "1 yr, 2 mths, 3 days, 4 hrs, 5 min, 6 secs"
        )
    }

    @Test func periodFormatting_explicitStyle() {
        #expect(
            Period.zero.formatted(style: .short, locale: enLocale)
            == "0 days"
        )
        #expect(
            Period(fullProps).formatted(style: .short, locale: enLocale)
            == "1 yr, 2 mths, 3 days"
        )
    }

    @Test func durationFormatting_explicitStyle() {
        #expect(
            Duration.zero.formatted(style: .short, locale: enLocale)
            == "0 secs"
        )
        #expect(
            Duration(fullProps).formatted(style: .short, locale: enLocale)
            == "4 hrs, 5 min, 6 secs"
        )
    }
}

extension FormattingTests {
    @Test func periodDurationFormatting_customAllowedUnits() {
        #expect(
            PeriodDuration.zero.formatted(allowedUnits: [.day, .hour, .minute, .second], locale: enLocale)
            == "0 seconds"
        )
        #expect(
            PeriodDuration(fullProps).formatted(allowedUnits: [.day, .hour, .minute, .second], locale: enLocale)
            == "427 days, 4 hours, 5 minutes, 6 seconds"
        )
    }

    @Test func periodFormatting_customAllowedUnits() {
        #expect(
            Period.zero.formatted(allowedUnits: [.day, .hour, .minute, .second], locale: enLocale)
            == "0 seconds"
        )
        #expect(
            Period(fullProps).formatted(allowedUnits: [.month, .minute], locale: enLocale)
            == "14 months, 4,320 minutes"
        )
    }

    @Test func durationFormatting_customAllowedUnits() {
        #expect(
            Duration.zero.formatted(allowedUnits: [.hour, .minute], locale: enLocale)
            == "0 minutes"
        )
        #expect(
            Duration(fullProps).formatted(allowedUnits: [.hour, .minute], locale: enLocale)
            == "4 hours, 5 minutes"
        )
    }
}

extension FormattingTests {
    @Test func periodDurationFormatting_esLocale() {
        #expect(
            PeriodDuration.zero.formatted(locale: esLocale)
            == "0 segundos"
        )
        #expect(
            PeriodDuration(fullProps).formatted(locale: esLocale)
            == "1 año, 2 meses, 3 días, 4 horas, 5 minutos y 6 segundos"
        )
    }

    @Test func periodFormatting_esLocale() {
        #expect(
            Period.zero.formatted(locale: esLocale)
            == "0 días"
        )
        #expect(
            Period(fullProps).formatted(locale: esLocale)
            == "1 año, 2 meses y 3 días"
        )
    }

    @Test func durationFormatting_esLocale() {
        #expect(
            Duration.zero.formatted(locale: esLocale)
            == "0 segundos"
        )
        #expect(
            Duration(fullProps).formatted(locale: esLocale)
            == "4 horas, 5 minutos y 6 segundos"
        )
    }
}
#endif

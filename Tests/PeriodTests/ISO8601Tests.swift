import Period
import RegexBuilder
import Testing

struct ISO8601Tests {
    @Test(arguments: scenarios)
    func period(input: String, output: Period?, identical: Bool) throws {
        #expect((try? Period(input, format: .iso8601)) == output, "input: \(input)")
        if let output, identical {
            #expect(output.formatted(.iso8601) == input)
        }
    }

    @Test func zeroFormatting() {
        #expect(Period.zero.formatted(.iso8601) == "PT0S")
    }

    // MARK: - ISO 8601-2 Negative Support

    @Test func negativeLeadingSign() throws {
        // Leading minus applies to all components
        #expect(try Period("-P3Y", format: .iso8601) == Period(years: -3))
        #expect(try Period("-P1Y2M", format: .iso8601) == Period(years: -1, months: -2))
        #expect(try Period("-PT5H", format: .iso8601) == Period(hours: -5))
        #expect(try Period("-P1DT2H", format: .iso8601) == Period(days: -1, hours: -2))
    }

    @Test func negativeLeadingPlus() throws {
        // Leading plus is explicit positive
        #expect(try Period("+P3Y", format: .iso8601) == Period(years: 3))
    }

    @Test func negativePerComponent() throws {
        // Per-component signs
        #expect(try Period("P-3Y", format: .iso8601) == Period(years: -3))
        #expect(try Period("P-1Y2M", format: .iso8601) == Period(years: -1, months: 2))
        #expect(try Period("P1Y-2M", format: .iso8601) == Period(years: 1, months: -2))
        #expect(try Period("PT-5H", format: .iso8601) == Period(hours: -5))
    }

    @Test func negativeFormatting() {
        // Formatting uses per-component signs
        #expect(Period(years: -3).formatted(.iso8601) == "P-3Y")
        #expect(Period(years: -1, months: 2).formatted(.iso8601) == "P-1Y2M")
        #expect(Period(hours: -5).formatted(.iso8601) == "PT-5H")
    }

    @Test func negativeRoundTrip() throws {
        // Round-trip negative values
        let period = Period(years: -1, months: 2, days: -3)
        #expect(try Period(period.formatted(.iso8601), format: .iso8601) == period)
    }

    @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
    @Test func regexMatch() {
        let regex = Regex {
            "Duration: "
            Capture { Period.ISO8601FormatStyle() }
        }

        let match = "Duration: P1Y2M3DT4H5M6S".firstMatch(of: regex)
        #expect(match?.output.1 == Period(years: 1, months: 2, days: 3, hours: 4, minutes: 5, seconds: 6))
    }

    @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
    @Test func regexMatchPartial() {
        let regex = Regex {
            Period.ISO8601FormatStyle()
        }

        let match = "P3Y trailing text".firstMatch(of: regex)
        #expect(match?.output == Period(years: 3))
    }

    @available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
    @Test func regexNoMatch() {
        let regex = Regex {
            Period.ISO8601FormatStyle()
        }

        let match = "no period here".firstMatch(of: regex)
        #expect(match == nil)
    }
}

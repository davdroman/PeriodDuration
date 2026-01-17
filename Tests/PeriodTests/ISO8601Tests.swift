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

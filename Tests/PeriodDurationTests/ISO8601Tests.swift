import PeriodDuration
import Testing

struct ISO8601Tests {
    @Test func periodDurationScenarios() throws {
        for s in scenarios {
            #expect(PeriodDuration(iso8601: s.input) == s.output.map(PeriodDuration.init), "input: \(s.input)")
            if let output = s.output, s.roundtrippingType == PeriodDuration.self {
                #expect(PeriodDuration(output).formatted(style: .iso8601) == s.input)
            }
        }
    }

    @Test func periodScenarios() throws {
        for s in scenarios {
            #expect(Period(iso8601: s.input) == s.output.map(Period.init), "input: \(s.input)")
            if let output = s.output, s.roundtrippingType == Period.self {
                #expect(Period(output).formatted(style: .iso8601) == s.input)
            }
        }
    }

    @Test func durationScenarios() throws {
        for s in scenarios {
            #expect(Duration(iso8601: s.input) == s.output.map(Duration.init), "input: \(s.input)")
            if let output = s.output, s.roundtrippingType == Duration.self {
                #expect(Duration(output).formatted(style: .iso8601) == s.input)
            }
        }
    }
}

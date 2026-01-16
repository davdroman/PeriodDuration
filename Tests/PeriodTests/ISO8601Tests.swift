import Period
import Testing

struct ISO8601Tests {
    @Test func periodScenarios() throws {
        for s in scenarios {
            #expect(Period(iso8601: s.input) == s.output.map(Period.init), "input: \(s.input)")
            if let output = s.output, s.roundtrippingType == Period.self {
                #expect(Period(output).formatted(style: .iso8601) == s.input)
            }
        }
    }
}

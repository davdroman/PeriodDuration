import Period
import Testing

struct ISO8601Tests {
    @Test func periodScenarios() throws {
        for s in scenarios {
            #expect(Period(iso8601: s.input) == s.output, "input: \(s.input)")
            if let output = s.output, s.identical {
                #expect(output.formatted(style: .iso8601) == s.input)
            }
        }
    }
}

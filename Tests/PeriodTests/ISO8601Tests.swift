import Period
import Testing

struct ISO8601Tests {
    @Test(arguments: scenarios)
    func period(input: String, output: Period?, identical: Bool) throws {
        #expect(Period(iso8601: input) == output, "input: \(input)")
        if let output, identical {
            #expect(output.formatted(.iso8601) == input)
        }
    }
}

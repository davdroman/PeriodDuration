import JSONTesting
import Period
import Testing

struct CodableTests {
    @Test(arguments: scenarios)
    func period(input: String, output: Period?, identical: Bool) throws {
        let json = JSON.string(input)
        let message = "rawValue: \(json)"

        try XCTAssertJSONCoding(output, message)

        if identical {
            try XCTAssertJSONEncoding(output, json)
        }

        do {
            try XCTAssertJSONDecoding(json, output, message)
        } catch let error as DecodingError where output == nil {
            switch error {
            case .dataCorrupted(let context):
                #expect(context.debugDescription == "Invalid Period ISO 8601 value \(json)")
            default:
                Issue.record("Unexpected `DecodingError` received: '\(error)' - \(message)")
            }
        } catch let error {
            Issue.record("Unexpected error received: '\(error)' - \(message)")
        }
    }
}

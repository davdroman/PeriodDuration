import CustomDump
import JSONTesting
import Period
import Testing

struct CodableTests {
    @Test(arguments: scenarios)
    func period(_ s: Scenario) throws {
        let json = JSON.string(s.input)
        let codable = s.output
        let message = "rawValue: \(json)"

        try XCTAssertJSONCoding(codable, message)

        if s.identical {
            try XCTAssertJSONEncoding(codable, json)
        }

        do {
            try XCTAssertJSONDecoding(json, codable, message)
        } catch let error as DecodingError where codable == nil {
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

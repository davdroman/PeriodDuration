import CustomDump
import JSONTesting
import Period
import Testing

struct CodableTests {
    @Test func periodScenarios() throws {
        for s in scenarios {
            try assert(.string(s.input), s.output.map(Period.init), identical: s.roundtrippingType == Period.self)
        }
    }
}

private extension CodableTests {
    func assert<T>(
        _ json: JSON,
        _ codable: T?,
        identical: Bool,
        sourceLocation: SourceLocation = #_sourceLocation
    ) throws where T: Codable, T: Equatable {
        let message = "rawValue: \(json)"
        try XCTAssertJSONCoding(codable, message)

        if identical {
            try XCTAssertJSONEncoding(codable, json)
        }

        do {
            try XCTAssertJSONDecoding(json, codable, message)
        } catch let error as DecodingError where codable == nil {
            switch error {
            case .dataCorrupted(let context):
                let type = "\(type(of: T.self))".prefix(while: { $0 != "." })
                #expect(context.debugDescription == "Invalid \(type) ISO 8601 value \(json)", sourceLocation: sourceLocation)
            default:
                Issue.record("Unexpected `DecodingError` received: '\(error)' - \(message)", sourceLocation: sourceLocation)
            }
        } catch let error {
            Issue.record("Unexpected error received: '\(error)' - \(message)", sourceLocation: sourceLocation)
        }
    }
}

import CustomDump
import PeriodDuration
import XCTJSONKit

final class CodableTests: XCTestCase {
    func testPeriodDurationScenarios() throws {
        for s in scenarios {
            try assert(.string(s.input), s.output.map(PeriodDuration.init), identical: s.strictForType == PeriodDuration.self)
        }
    }

    func testPeriodScenarios() throws {
        for s in scenarios {
            try assert(.string(s.input), s.output.map(Period.init), identical: s.strictForType == Period.self)
        }
    }

    func testDurationScenarios() throws {
        for s in scenarios {
            try assert(.string(s.input), s.output.map(Duration.init), identical: s.strictForType == Duration.self)
        }
    }
}

private extension CodableTests {
    func assert<T>(
        _ json: JSON,
        _ codable: T?,
        identical: Bool,
        file: StaticString = #filePath,
        line: UInt = #line
    ) throws where T: Codable, T: Equatable {
        let message = "rawValue: \(json)"
        try XCTAssertJSONCoding(codable, message, file: file, line: line)

        if identical {
            try XCTAssertJSONEncoding(codable, json)
        }

        do {
            try XCTAssertJSONDecoding(json, codable, message, file: file, line: line)
        } catch let error as DecodingError where codable == nil {
            switch error {
            case .dataCorrupted(let context):
                let type = "\(type(of: T.self))".prefix(while: { $0 != "." })
                XCTAssertEqual(context.debugDescription, "Invalid \(type) ISO 8601 value \(json)", file: file, line: line)
            default:
                XCTFail("Unexpected `DecodingError` received: '\(error)' - \(message)", file: file, line: line)
            }
        } catch let error {
            XCTFail("Unexpected error received: '\(error)' - \(message)", file: file, line: line)
        }
    }
}

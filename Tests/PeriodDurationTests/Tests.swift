import CustomDump
import PeriodDuration
import XCTJSONKit

final class Tests: XCTestCase {
    func testPeriodDurationScenarios() throws {
        for s in scenarios {
            try assert(s.input, s.output.map(PeriodDuration.init), identical: s.strictForType == PeriodDuration.self)
        }
    }

    func testPeriodScenarios() throws {
        for s in scenarios {
            try assert(s.input, s.output.map(Period.init), identical: s.strictForType == Period.self)
        }
    }

    func testDurationScenarios() throws {
        for s in scenarios {
            try assert(s.input, s.output.map(Duration.init), identical: s.strictForType == Duration.self)
        }
    }
}

private extension Tests {
    func assert<T>(
        _ rawValue: String,
        _ value: T?,
        identical: Bool,
        file: StaticString = #filePath,
        line: UInt = #line
    ) throws where T: Codable, T: Equatable {
        let message = "rawValue: \(rawValue)"
        try XCTAssertJSONCoding(value, message, file: file, line: line)

        if identical {
            try XCTAssertJSONEncoding(value, JSON(rawValue))
        }

        do {
            try XCTAssertJSONDecoding(JSON(rawValue), value, message, file: file, line: line)
        } catch let error as DecodingError where value == nil {
            switch error {
            case .dataCorrupted(let context):
                let type = "\(type(of: T.self))".prefix(while: { $0 != "." })
                XCTAssertEqual(context.debugDescription, "Invalid \(type) rawValue '\(rawValue)'", file: file, line: line)
            default:
                XCTFail("Unexpected `DecodingError` received: '\(error)' - \(message)", file: file, line: line)
            }
        } catch let error {
            XCTFail("Unexpected error received: '\(error)' - \(message)", file: file, line: line)
        }
    }
}

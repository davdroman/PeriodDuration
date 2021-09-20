import CustomDump
import PeriodDuration
import XCTJSONKit

final class Tests: XCTestCase {
    func testPeriodDurationScenarios() throws {
        for (rawValue, props) in scenarios {
            try assert(rawValue, props.map(PeriodDuration.init))
        }
    }

    func testPeriodScenarios() throws {
        for (rawValue, props) in scenarios {
            try assert(rawValue, props.map(Period.init))
        }
    }

    func testDurationScenarios() throws {
        for (rawValue, props) in scenarios {
            try assert(rawValue, props.map(Duration.init))
        }
    }
}

private extension Tests {
    func assert<T>(_ rawValue: String, _ value: T?, file: StaticString = #filePath, line: UInt = #line) throws where T: Codable, T: Equatable {
        let message = "rawValue: \(rawValue)"
        try XCTAssertJSONCoding(value, message, file: file, line: line)

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

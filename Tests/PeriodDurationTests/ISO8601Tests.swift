import PeriodDuration
import XCTest

final class ISO8601Tests: XCTestCase {
    func testPeriodDurationScenarios() throws {
        for s in scenarios {
            XCTAssertEqual(PeriodDuration(iso8601: s.input), s.output.map(PeriodDuration.init), "input: \(s.input)")
            if let output = s.output, s.strictForType == PeriodDuration.self {
                XCTAssertEqual(PeriodDuration(output).formatted(style: .iso8601), s.input)
            }
        }
    }

    func testPeriodScenarios() throws {
        for s in scenarios {
            XCTAssertEqual(Period(iso8601: s.input), s.output.map(Period.init), "input: \(s.input)")
            if let output = s.output, s.strictForType == Period.self {
                XCTAssertEqual(Period(output).formatted(style: .iso8601), s.input)
            }
        }
    }

    func testDurationScenarios() throws {
        for s in scenarios {
            XCTAssertEqual(Duration(iso8601: s.input), s.output.map(Duration.init), "input: \(s.input)")
            if let output = s.output, s.strictForType == Duration.self {
                XCTAssertEqual(Duration(output).formatted(style: .iso8601), s.input)
            }
        }
    }
}

import JSONTesting
import Period
import XCTest

final class CodableTests: XCTestCase {
	func testCoding() throws {
		for (input, expected, roundTrips) in iso8601TestCases {
			let json = JSON.string(input)
			let message = "rawValue: \(json)"

			try XCTAssertJSONCoding(expected, message)

			if roundTrips {
				try XCTAssertJSONEncoding(expected, json)
			}

			do {
				try XCTAssertJSONDecoding(json, expected, message)
			} catch let error as DecodingError where expected == nil {
				switch error {
				case .dataCorrupted(let context):
					XCTAssertEqual(context.debugDescription, "Invalid ISO 8601 duration \(json)", message)
				default:
					XCTFail("Unexpected `DecodingError` received: '\(error)' - \(message)")
				}
			} catch let error {
				XCTFail("Unexpected error received: '\(error)' - \(message)")
			}
		}
	}
}

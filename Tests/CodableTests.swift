import JSONTesting
import Period
import Testing

struct CodableTests {
	@Test(arguments: iso8601TestCases)
	func coding(input: String, expected: Period?, roundTrips: Bool) throws {
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
			case let .dataCorrupted(context):
				#expect(context.debugDescription == "Invalid ISO 8601 duration \(json)")
			default:
				Issue.record("Unexpected `DecodingError` received: '\(error)' - \(message)")
			}
		} catch let error {
			Issue.record("Unexpected error received: '\(error)' - \(message)")
		}
	}
}

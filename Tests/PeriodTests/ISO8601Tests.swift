import Period
import XCTest
#if canImport(RegexBuilder)
import RegexBuilder
#endif

final class ISO8601Tests: XCTestCase {
	func testParsing() throws {
		for (input, expected, roundTrips) in iso8601TestCases {
			XCTAssertEqual(try? Period(input, format: .iso8601), expected, "input: \(input)")
			if let expected, roundTrips {
				XCTAssertEqual(expected.formatted(.iso8601), input)
			}
		}
	}

	#if canImport(RegexBuilder)
	@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
	func testRegexMatch() {
		let regex = Regex {
			"Duration: "
			Capture { Period.ISO8601FormatStyle() }
		}

		let match = "Duration: P1Y2M3DT4H5M6S".firstMatch(of: regex)
		XCTAssertEqual(match?.output.1, Period(years: 1, months: 2, days: 3, hours: 4, minutes: 5, seconds: 6))
	}

	@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
	func testRegexMatchPartial() {
		let regex = Regex {
			Period.ISO8601FormatStyle()
		}

		let match = "P3Y trailing text".firstMatch(of: regex)
		XCTAssertEqual(match?.output, Period(years: 3))
	}

	@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
	func testRegexNoMatch() {
		let regex = Regex {
			Period.ISO8601FormatStyle()
		}

		let match = "no period here".firstMatch(of: regex)
		XCTAssertNil(match)
	}
	#endif
}

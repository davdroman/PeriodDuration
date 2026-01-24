import Foundation

extension Period {
	public struct ISO8601FormatStyle: ParseableFormatStyle, ParseStrategy {
		public init() {}

		public func format(_ value: Period) -> String {
			var result = "P"
			result += value.years.withSuffix("Y")
			result += value.months.withSuffix("M")
			result += value.days.withSuffix("D")

			let hasDatePart = value.years != 0 || value.months != 0 || value.days != 0
			let hasTimePart = value.hours != 0 || value.minutes != 0 || value.seconds != 0

			guard hasTimePart || !hasDatePart else { return result }
			result += "T"
			result += value.hours.withSuffix("H")
			result += value.minutes.withSuffix("M")
			result += hasTimePart ? value.seconds.withSuffix("S") : "0S"

			return result
		}

		public var parseStrategy: Self { self }

		public func parse(_ value: String) throws -> Period {
			guard let period = Parser.parse(value) else {
				throw ParsingError(input: value)
			}
			return period
		}

		public struct ParsingError: Error, CustomStringConvertible {
			public let input: String

			public var description: String {
				"Invalid ISO 8601 duration: \"\(input)\""
			}
		}

		enum Parser {
			static let regex = try! NSRegularExpression(
				pattern: #"([+-])?P(?:(-?\d+)?Y)?(?:(-?\d+)?M)?(?:(-?\d+)?W)?(?:(-?\d+)?D)?(?:T(?:(-?\d+)?H)?(?:(-?\d+)?M)?(?:(-?\d+)?S)?)?"#
			)

			static func parse(_ string: String) -> Period? {
				let range = NSRange(string.startIndex..., in: string)
				guard let match = regex.firstMatch(in: string, options: .anchored, range: range),
					  match.range.length == string.utf16.count else {
					return nil
				}
				return period(from: match, in: string)
			}

			static func period(from match: NSTextCheckingResult, in string: String) -> Period? {
				func extractInt(at index: Int) -> Int? {
					let range = match.range(at: index)
					guard range.location != NSNotFound,
						  let swiftRange = Range(range, in: string) else { return nil }
					return Int(string[swiftRange])
				}

				let leadingSign: Int = if let signRange = Range(match.range(at: 1), in: string) {
					string[signRange] == "-" ? -1 : 1
				} else {
					1
				}

				let years = extractInt(at: 2)
				let months = extractInt(at: 3)
				let weeks = extractInt(at: 4)
				let days = extractInt(at: 5)
				let hours = extractInt(at: 6)
				let minutes = extractInt(at: 7)
				let seconds = extractInt(at: 8)

				guard years != nil || months != nil || weeks != nil || days != nil ||
					hours != nil || minutes != nil || seconds != nil
				else {
					return nil
				}

				return Period(
					years: (years ?? 0) * leadingSign,
					months: (months ?? 0) * leadingSign,
					days: ((weeks ?? 0) * 7 + (days ?? 0)) * leadingSign,
					hours: (hours ?? 0) * leadingSign,
					minutes: (minutes ?? 0) * leadingSign,
					seconds: (seconds ?? 0) * leadingSign
				)
			}
		}
	}
}

extension Period.ISO8601FormatStyle {
	public static var iso8601: Self { .init() }
}

// MARK: Formatting

extension Period {
	public func formatted(_ style: ISO8601FormatStyle) -> String {
		style.format(self)
	}
}

// MARK: Parsing

extension Period {
	public init(_ value: String, format: ISO8601FormatStyle) throws {
		try self.init(value, strategy: format.parseStrategy)
	}

	public init<S: ParseStrategy>(_ value: S.ParseInput, strategy: S) throws where S.ParseOutput == Self {
		self = try strategy.parse(value)
	}
}

extension Numeric {
	fileprivate func withSuffix(_ c: Character) -> String {
		if self == .zero {
			""
		} else {
			"\(self)\(c)"
		}
	}
}

// MARK: Regex

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
extension Period.ISO8601FormatStyle: CustomConsumingRegexComponent {
	public typealias RegexOutput = Period

	public func consuming(_ input: String, startingAt index: String.Index, in bounds: Range<String.Index>) throws -> (upperBound: String.Index, output: Period)? {
		guard index < bounds.upperBound else { return nil }

		let substring = String(input[index..<bounds.upperBound])
		let range = NSRange(substring.startIndex..., in: substring)

		guard let match = Parser.regex.firstMatch(in: substring, options: .anchored, range: range),
		      let period = Parser.period(from: match, in: substring)
		else {
			return nil
		}

		let matchEnd = input.index(index, offsetBy: match.range.length)
		return (matchEnd, period)
	}
}

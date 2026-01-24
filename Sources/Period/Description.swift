import Foundation

extension Period: CustomStringConvertible {
	public var description: String {
		[
			self.years.nilIfZero.map { "\($0) year\($0 == 1 ? "" : "s")" },
			self.months.nilIfZero.map { "\($0) month\($0 == 1 ? "" : "s")" },
			self.days.nilIfZero.map { "\($0) day\($0 == 1 ? "" : "s")" },
			self.hours.nilIfZero.map { "\($0) hour\($0 == 1 ? "" : "s")" },
			self.minutes.nilIfZero.map { "\($0) minute\($0 == 1 ? "" : "s")" },
			self.seconds.nilIfZero.map { "\($0) second\($0 == 1 ? "" : "s")" },
		]
		.lazy
		.compactMap(\.self)
		.joined(separator: ", ")
	}
}

extension Numeric {
	fileprivate var nilIfZero: Self? {
		self == .zero ? nil : self
	}
}

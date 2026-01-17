#if canImport(Darwin)
import Foundation

extension Period {
	public struct FormatStyle: Foundation.FormatStyle, Sendable {
		public enum Style: Hashable, Codable, Sendable {
			case positional, abbreviated, brief, short, full, spellOut

			fileprivate var rawValue: DateComponentsFormatter.UnitsStyle {
				switch self {
				case .positional: .positional
				case .abbreviated: .abbreviated
				case .brief: .brief
				case .short: .short
				case .full: .full
				case .spellOut: .spellOut
				}
			}
		}

		public struct Unit: OptionSet, Hashable, Codable, Sendable {
			public static let year = Unit(rawValue: 1 << 0)
			public static let month = Unit(rawValue: 1 << 1)
			public static let day = Unit(rawValue: 1 << 2)
			public static let hour = Unit(rawValue: 1 << 3)
			public static let minute = Unit(rawValue: 1 << 4)
			public static let second = Unit(rawValue: 1 << 5)

			public static let all: Unit = [.year, .month, .day, .hour, .minute, .second]

			public let rawValue: Int
			public init(rawValue: Int) { self.rawValue = rawValue }

			fileprivate var calendarUnits: NSCalendar.Unit {
				var units: NSCalendar.Unit = []
				if contains(.year) { units.insert(.year) }
				if contains(.month) { units.insert(.month) }
				if contains(.day) { units.insert(.day) }
				if contains(.hour) { units.insert(.hour) }
				if contains(.minute) { units.insert(.minute) }
				if contains(.second) { units.insert(.second) }
				return units
			}
		}

		var style: Style = .full
		var allowedUnits: Unit = .all
		var locale: Locale = .autoupdatingCurrent

		public init() {}

		// MARK: - Presets

		public static var positional: Self { .init(style: .positional) }
		public static var abbreviated: Self { .init(style: .abbreviated) }
		public static var brief: Self { .init(style: .brief) }
		public static var short: Self { .init(style: .short) }
		public static var full: Self { .init(style: .full) }
		public static var spellOut: Self { .init(style: .spellOut) }

		private init(style: Style) {
			self.style = style
		}

		// MARK: - Chainable configuration

		public func style(_ style: Style) -> Self {
			var copy = self
			copy.style = style
			return copy
		}

		public func allowedUnits(_ units: Unit) -> Self {
			var copy = self
			copy.allowedUnits = units
			return copy
		}

		public func locale(_ locale: Locale) -> Self {
			var copy = self
			copy.locale = locale
			return copy
		}

		// MARK: - FormatStyle conformance

		public func format(_ value: Period) -> String {
			let config = FormatterConfig(style: style.rawValue, allowedUnits: allowedUnits.calendarUnits, locale: locale)
			let formatter = FormatterCache.shared.formatter(for: config)
			return formatter.string(from: DateComponents(value)) ?? ""
		}
	}

	public func formatted() -> String {
		FormatStyle().format(self)
	}

	public func formatted(_ style: FormatStyle) -> String {
		style.format(self)
	}
}

private struct FormatterConfig: Hashable, Sendable {
	let style: DateComponentsFormatter.UnitsStyle
	let allowedUnits: NSCalendar.Unit
	let locale: Locale

	func hash(into hasher: inout Hasher) {
		hasher.combine(style)
		hasher.combine(allowedUnits.rawValue)
		hasher.combine(locale)
	}
}

private struct FormatterCache: Sendable {
	static let shared = FormatterCache()

	private let storage = Mutex<[FormatterConfig: DateComponentsFormatter]>([:])

	func formatter(for config: FormatterConfig) -> DateComponentsFormatter {
		if let existing = storage.withLock({ $0[config] }) {
			return existing
		}

		let formatter = DateComponentsFormatter()
		var calendar = Calendar(identifier: .iso8601)
		calendar.timeZone = TimeZone(secondsFromGMT: 0)!
		calendar.locale = config.locale
		formatter.calendar = calendar
		formatter.unitsStyle = config.style
		formatter.allowedUnits = config.allowedUnits

		storage.withLock { cache in
			// Prevent unbounded memory growth by clearing cache if too many unique configurations accumulate
			if cache.count > 100 {
				cache.removeAll()
			}
			cache[config] = formatter
		}

		return formatter
	}
}

// Adapted from https://github.com/apple/swift-argument-parser/blob/main/Sources/ArgumentParser/Utilities/Mutex.swift
private struct Mutex<State>: @unchecked Sendable {
	private final class Buffer: ManagedBuffer<State, os_unfair_lock> {
		deinit {
			_ = withUnsafeMutablePointerToElements { $0.deinitialize(count: 1) }
		}
	}

	private let buffer: ManagedBuffer<State, os_unfair_lock>

	init(_ initialState: State) {
		buffer = Buffer.create(minimumCapacity: 1) { buffer in
			buffer.withUnsafeMutablePointerToElements { $0.initialize(to: os_unfair_lock()) }
			return initialState
		}
	}

	func withLock<R>(_ body: (inout State) throws -> R) rethrows -> R {
		try buffer.withUnsafeMutablePointers { state, lock in
			os_unfair_lock_lock(lock)
			defer { os_unfair_lock_unlock(lock) }
			return try body(&state.pointee)
		}
	}
}
#endif

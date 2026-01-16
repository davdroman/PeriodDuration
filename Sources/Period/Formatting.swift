#if !os(Linux)
import Foundation

extension Period {
    public struct FormatStyle: Hashable, Sendable {
        public static let positional = FormatStyle(.positional)
        public static let abbreviated = FormatStyle(.abbreviated)
        public static let brief = FormatStyle(.brief)
        public static let short = FormatStyle(.short)
        public static let full = FormatStyle(.full)
        public static let spellOut = FormatStyle(.spellOut)

        fileprivate let rawValue: DateComponentsFormatter.UnitsStyle
        private init(_ rawValue: DateComponentsFormatter.UnitsStyle) { self.rawValue = rawValue }
    }

    public struct Unit: OptionSet, Hashable, Sendable {
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

    public func formatted(
        style: FormatStyle = .full,
        allowedUnits: Unit = .all,
        locale: Locale
    ) -> String {
        let config = FormatterConfig(style: style.rawValue, allowedUnits: allowedUnits.calendarUnits, locale: locale)
        let formatter = FormatterCache.shared.formatter(for: config)
        return formatter.string(from: DateComponents(self)) ?? ""
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

    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.style == rhs.style && lhs.allowedUnits == rhs.allowedUnits && lhs.locale == rhs.locale
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

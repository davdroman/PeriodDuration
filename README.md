# Period

[![CI](https://github.com/davdroman/Period/actions/workflows/ci.yml/badge.svg)](https://github.com/davdroman/Period/actions/workflows/ci.yml)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fdavdroman%2FPeriod%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/davdroman/Period)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fdavdroman%2FPeriod%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/davdroman/Period)

A Swift implementation of ISO 8601 durations. Zero dependencies.

## Installation

```swift
.package(url: "https://github.com/davdroman/Period", from: "1.0.0")
```

## Usage

### Creating a Period

```swift
import Period

// Specify components directly
let period = Period(years: 1, months: 6, days: 15)
let workday = Period(hours: 8)
let timeout = Period(minutes: 30, seconds: 45)

// All components default to zero
let oneYear = Period(years: 1)  // months, days, hours, etc. are all 0
```

### ISO 8601 Parsing

```swift
// Basic format
let period = try Period("P1Y6M15D", format: .iso8601)
let time = try Period("PT8H30M", format: .iso8601)
let full = try Period("P1Y2M3DT4H5M6S", format: .iso8601)

// Week format (converted to days)
let twoWeeks = try Period("P2W", format: .iso8601)  // Period(days: 14)

// ISO 8601-2: Negative durations
let negative = try Period("-P1Y", format: .iso8601)      // Period(years: -1)
let mixed = try Period("P-1Y2M", format: .iso8601)       // Period(years: -1, months: 2)
```

### Formatting

```swift
// ISO 8601
Period(years: 1, months: 2).formatted(.iso8601)           // "P1Y2M"
Period(hours: 5, minutes: 30).formatted(.iso8601)         // "PT5H30M"
Period.zero.formatted(.iso8601)                           // "PT0S"
Period(years: -1, months: 2).formatted(.iso8601)          // "P-1Y2M"

// Human-readable (localized)
Period(years: 1, months: 2).formatted(.full)              // "1 year, 2 months"
Period(hours: 2, minutes: 30).formatted(.short)           // "2 hrs, 30 min"
```

### Arithmetic

```swift
let a = Period(years: 1, months: 6)
let b = Period(months: 3)

// Addition and subtraction
let sum = a + b             // Period(years: 1, months: 9)
let diff = a - b            // Period(years: 1, months: 3)

// Compound assignment
var period = Period(days: 7)
period += Period(days: 3)   // Period(days: 10)

// Scalar multiplication
let doubled = a * 2         // Period(years: 2, months: 12)
let tripled = 3 * a         // Period(years: 3, months: 18)

// Negation
let neg = -period           // Period(days: -10)
period.negate()             // mutates in place
```

### Calendar Operations

```swift
let calendar = Calendar.current
let now = Date()

// Add a period to a date
let future = calendar.date(byAdding: Period(years: 1, months: 6), to: now)

// Compute period between dates
let elapsed = calendar.period(from: startDate, to: endDate)
```

### Codable

`Period` is `Codable` using ISO 8601 format:

```swift
struct Subscription: Codable {
    let billingPeriod: Period
}

// Decodes from: {"billingPeriod": "P1M"}
// Encodes to:   {"billingPeriod": "P1M"}
```

### Regex Matching

`Period.ISO8601FormatStyle` conforms to `CustomConsumingRegexComponent`:

```swift
import RegexBuilder

let regex = Regex {
    "Duration: "
    Capture { Period.ISO8601FormatStyle() }
}

if let match = "Duration: P1Y2M".firstMatch(of: regex) {
    print(match.output.1)  // Period(years: 1, months: 2)
}
```

## Equality

`Period` conforms to `Equatable` but not `Comparable`. Two periods are equal only if all their components match exactly:

```swift
Period(months: 12) == Period(years: 1)  // false (different components)
Period(months: 12) == Period(months: 12)  // true
```

Periods cannot be meaningfully compared without a reference date since months and years have variable lengths.

## ISO 8601 Compliance

This implementation supports both ISO 8601-1 and ISO 8601-2:

| Feature | Example | Support |
|---------|---------|---------|
| Basic format | `P1Y2M3DT4H5M6S` | Yes |
| Week format | `P2W` | Yes (converted to days) |
| Weeks with other units | `P1W3D` | Yes (ISO 8601-2 extension) |
| Negative duration | `-P1Y` | Yes (ISO 8601-2) |
| Per-component signs | `P-1Y2M` | Yes (ISO 8601-2) |
| Fractional values | `PT1.5H` | No |

## Benchmarks

```
MacBook Pro (14-inch, 2021)
Apple M1 Pro (10 cores, 8 performance and 2 efficiency)
32 GB Memory

$ swift run -c release Benchmarks

name                   time        std        iterations
--------------------------------------------------------
parse P3Y              1834.000 ns ±  69.20 %     702009
parse PT5H30M          2125.000 ns ±  64.31 %     612154
parse P1Y2M3DT4H5M6S   2416.000 ns ±  58.43 %     538787
parse P3Y3M3W3DT3H3M3S 2375.000 ns ±  61.90 %     554537
parse -P1Y2M           1959.000 ns ±  67.23 %     658447
parse P-1Y2M-3D        2041.000 ns ±  65.14 %     642590
parse PT0S             2084.000 ns ±  63.98 %     624773
format P3Y              334.000 ns ±  92.43 %    1000000
format PT5H30M          583.000 ns ±  82.43 %    1000000
format P1Y2M3DT4H5M6S  1292.000 ns ±  57.21 %    1000000
format .zero            167.000 ns ± 152.35 %    1000000
```

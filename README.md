# PeriodDuration

[![CI](https://github.com/davdroman/PeriodDuration/actions/workflows/ci.yml/badge.svg)](https://github.com/davdroman/PeriodDuration/actions/workflows/ci.yml)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fdavdroman%2FPeriodDuration%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/davdroman/PeriodDuration)

This library introduces a close equivalent to [Java's PeriodDuration](https://www.threeten.org/threeten-extra/apidocs/org.threeten.extra/org/threeten/extra/PeriodDuration.html), motivated by the lack of support for this standard in Foundation.

`PeriodDuration` is based off of a [previous library](https://github.com/treatwell/ISO8601PeriodDuration) I worked on, however it goes beyond simple serialization by introducing dedicated types with full ISO 8601 compliant `Codable` support.

## Usage

Available types: `Period`, `Duration` and `PeriodDuration`.

### Period

[ISO 8601](https://en.wikipedia.org/wiki/ISO_8601#Durations) defines a "Period" as a combination of _years_, _months_, and _days_ elapsed. Periods **do not** include _hours_, _minutes_ or _seconds_.

```swift
Period(years: 3, months: 1, days: 5) // = "P3Y1M5D"
```

### Duration

[ISO 8601](https://en.wikipedia.org/wiki/ISO_8601#Durations) defines a "Duration" as a combination of _hours_, _minutes_ or _seconds_ elapsed. Durations **do not** include _years_, _months_, and _days_.

```swift
Duration(hours: 2, minutes: 5, seconds: 0) // = "PT2H5M0S"
```

### PeriodDuration

`PeriodDuration` is a combinations of _years_, _months_, _days_, _hours_, _minutes_ and _seconds_ elapsed. As a type, it holds both a `Period` and a `Duration` instance within it to represent all of these values.

```swift
PeriodDuration(years: 3, months: 1, days: 5, hours: 2, minutes: 5, seconds: 0) // = "P3Y1M5DT2H5M0S"
```

### Conversion to DateComponents

All three types provided allow for easy conversion into the built-in `DateComponents` type in Foundation.

```swift
let dateComponents: DateComponents = Period(years: 3, months: 1, days: 5).asDateComponents
```

This allows for a number of handy things. Namely:

- Date manipulation: adding periods/durations to `Date` instances via [`Calendar.date(byAdding:to:wrappingComponents:)`](https://developer.apple.com/documentation/foundation/calendar/2293676-date/).
- Human-readable formatting via [`DateComponentsFormatter`](https://developer.apple.com/documentation/foundation/datecomponentsformatter).

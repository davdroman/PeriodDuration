import PeriodDuration
import Benchmark

benchmark("parse PeriodDuration") {
    _ = PeriodDuration(iso8601: "P3Y3M3W3DT3H3M3S")
}

benchmark("print PeriodDuration") {
    _ = PeriodDuration(years: 3, months: 3, days: 3, hours: 3, minutes: 3, seconds: 3).formatted(style: .iso8601)
}

benchmark("parse Period") {
    _ = Period(iso8601: "P3Y3M3W3D")
}

benchmark("print Period") {
    _ = Period(years: 3, months: 3, days: 3).formatted(style: .iso8601)
}

benchmark("parse Duration") {
    _ = Duration(iso8601: "PT3H3M3S")
}

benchmark("print Duration") {
    _ = Duration(hours: 3, minutes: 3, seconds: 3).formatted(style: .iso8601)
}

Benchmark.main()

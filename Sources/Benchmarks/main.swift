import Period
import Benchmark

benchmark("parse Period") {
    _ = Period(iso8601: "P3Y3M3W3DT3H3M3S")
}

benchmark("print Period") {
    _ = Period(years: 3, months: 3, days: 3, hours: 3, minutes: 3, seconds: 3).formatted(.iso8601)
}

Benchmark.main()

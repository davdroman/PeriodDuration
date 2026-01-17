import Benchmark
import Period

// MARK: - Parsing

benchmark("parse P3Y") {
	_ = try! Period("P3Y", format: .iso8601)
}

benchmark("parse PT5H30M") {
	_ = try! Period("PT5H30M", format: .iso8601)
}

benchmark("parse P1Y2M3DT4H5M6S") {
	_ = try! Period("P1Y2M3DT4H5M6S", format: .iso8601)
}

benchmark("parse P3Y3M3W3DT3H3M3S") {
	_ = try! Period("P3Y3M3W3DT3H3M3S", format: .iso8601)
}

benchmark("parse -P1Y2M") {
	_ = try! Period("-P1Y2M", format: .iso8601)
}

benchmark("parse P-1Y2M-3D") {
	_ = try! Period("P-1Y2M-3D", format: .iso8601)
}

benchmark("parse PT0S") {
	_ = try! Period("PT0S", format: .iso8601)
}

// MARK: - Formatting

benchmark("format P3Y") {
	_ = Period(years: 3).formatted(.iso8601)
}

benchmark("format PT5H30M") {
	_ = Period(hours: 5, minutes: 30).formatted(.iso8601)
}

benchmark("format P1Y2M3DT4H5M6S") {
	_ = Period(years: 1, months: 2, days: 3, hours: 4, minutes: 5, seconds: 6).formatted(.iso8601)
}

benchmark("format .zero") {
	_ = Period.zero.formatted(.iso8601)
}

Benchmark.main()

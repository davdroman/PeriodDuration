// swift-tools-version:6.0

import PackageDescription

let package = Package(
	name: "Period",
	platforms: [
		.iOS(.v15),
		.tvOS(.v15),
		.macOS(.v12),
		.watchOS(.v8),
	],
	products: [
		.library(name: "Period", targets: ["Period"]),
	],
	targets: [
		.target(name: "Period"),
		.testTarget(name: "PeriodTests", dependencies: [
			.target(name: "Period"),
			.product(name: "JSONTesting", package: "swift-json-testing"),
		]),

		.executableTarget(name: "Benchmarks", dependencies: [
			.target(name: "Period"),
			.product(name: "Benchmark", package: "swift-benchmark"),
		]),
	]
)

package.dependencies = [
	.package(url: "https://github.com/google/swift-benchmark", from: "0.1.2"),
	.package(url: "https://github.com/davdroman/swift-json-testing", from: "0.2.0"),
]

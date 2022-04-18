// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PeriodDuration",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6),
    ],
    products: [
        .library(name: "PeriodDuration", targets: ["PeriodDuration"]),
    ],
    targets: [
        .target(name: "PeriodDuration"),
        .testTarget(name: "PeriodDurationTests", dependencies: [
            .target(name: "PeriodDuration"),
            .product(name: "XCTJSONKit", package: "XCTJSONKit"),
        ]),

        .executableTarget(name: "Benchmarks", dependencies: [
            .target(name: "PeriodDuration"),
            .product(name: "Benchmark", package: "swift-benchmark"),
        ]),
    ]
)

package.dependencies = [
    .package(url: "https://github.com/google/swift-benchmark", from: "0.1.1"),
    .package(url: "https://github.com/davdroman/XCTJSONKit", .branch("main")),
]

// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "PeriodDuration",
    platforms: [
        .iOS(.v13),
        .tvOS(.v13),
        .macOS(.v10_15),
        .watchOS(.v6),
    ],
    products: [
        .library(name: "PeriodDuration", targets: ["PeriodDuration"]),
    ],
    targets: [
        .target(name: "PeriodDuration", dependencies: [
            .product(name: "Parsing", package: "swift-parsing"),
        ]),
        .testTarget(name: "PeriodDurationTests", dependencies: [
            .target(name: "PeriodDuration"),
            .product(name: "JSONTesting", package: "swift-json-testing"),
        ]),

        .executableTarget(name: "Benchmarks", dependencies: [
            .target(name: "PeriodDuration"),
            .product(name: "Benchmark", package: "swift-benchmark"),
        ]),
    ]
)

package.dependencies = [
    .package(url: "https://github.com/google/swift-benchmark", from: "0.1.2"),
    .package(url: "https://github.com/pointfreeco/swift-parsing", from: "0.13.0"),
    .package(url: "https://github.com/davdroman/swift-json-testing", from: "0.2.0"),
]

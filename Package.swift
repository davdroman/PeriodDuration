// swift-tools-version:5.4
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
        .testTarget(name: "PeriodDurationTests", dependencies: ["PeriodDuration", "XCTJSONKit"]), // dev
    ]
)

package.dependencies = [
    .package(url: "https://github.com/shibapm/Rocket", from: "1.0.0"), // dev
    .package(url: "https://github.com/davdroman/XCTJSONKit", .branch("main")), // dev
]

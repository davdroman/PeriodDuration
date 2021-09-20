// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PeriodDuration",
    products: [
        .library(name: "PeriodDuration", targets: ["PeriodDuration"]),
    ],
    targets: [
        .target(name: "PeriodDuration"),
        .testTarget(name: "PeriodDurationTests", dependencies: [
            .target(name: "PeriodDuration"),
            .product(name: "XCTJSONKit", package: "XCTJSONKit"),
        ]),
    ]
)

package.dependencies = [
    .package(url: "https://github.com/davdroman/XCTJSONKit", .branch("main")),
]

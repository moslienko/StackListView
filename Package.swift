// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "StackListView",
    platforms: [
        .iOS(.v9),
        .tvOS(.v9),
        .watchOS(.v2),
        .macOS(.v10_10)
    ],
    products: [
        .library(
            name: "StackListView",
            targets: ["StackListView"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "StackListView",
            dependencies: [],
            path: "Sources"
        ),
        .testTarget(
            name: "StackListViewTests",
            dependencies: ["StackListView"],
            path: "Tests"
        ),
    ]
)

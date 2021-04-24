// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "StackListView",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "StackListView",
            targets: ["StackListView"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/moslienko/AppViewUtilits.git", from: "1.2.1")
    ],
    targets: [
        .target(
            name: "StackListView",
            dependencies: [
                .package(url: "https://github.com/moslienko/AppViewUtilits.git", from: "1.2.1")
            ],
            path: "Sources"
        ),
        .testTarget(
            name: "StackListViewTests",
            dependencies: ["StackListView"],
            path: "Tests"
        ),
    ]
)

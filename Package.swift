// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// VERSION: 0.1.0

let package = Package(
    name: "SwiftChain",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "SwiftChain",
            targets: ["SwiftChain"]),
    ],
    targets: [
        .target(
            name: "SwiftChain"),
        .testTarget(
            name: "SwiftChainTests",
            dependencies: ["SwiftChain"]),
    ]
)

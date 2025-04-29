// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "link_bridge",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "link_bridge",
            targets: ["link_bridge"]
        )
    ],
    targets: [
        .target(
            name: "link_bridge",
            path: ".",
            sources: ["Classes"]
        ),
        .testTarget(
            name: "link_bridgeTests",
            dependencies: ["link_bridge"],
            path: "Tests"
        )
    ]
)

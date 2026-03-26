// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "ToastKit",
    platforms: [
        .iOS(.v16),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "ToastKit",
            targets: ["ToastKit"]
        ),
    ],
    targets: [
        .target(
            name: "ToastKit",
            path: "Sources/ToastKit",
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency")
            ]
        ),
        .testTarget(
            name: "ToastKitTests",
            dependencies: ["ToastKit"],
            path: "Tests/ToastKitTests"
        ),
    ],
    swiftLanguageVersions: [.v5]
)

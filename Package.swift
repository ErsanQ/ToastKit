// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "ToastKit",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .tvOS(.v14),
        .watchOS(.v7),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "ToastKit",
            targets: ["ToastKit"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ToastKit",
            dependencies: [],
            path: "Sources/ToastKit"),
        .testTarget(
            name: "ToastKitTests",
            dependencies: ["ToastKit"],
            path: "Tests/ToastKitTests"),
    ]
)

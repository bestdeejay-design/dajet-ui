// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "DajetUI",
    platforms: [.macOS(.v14)],
    products: [
        .library(name: "DajetUI", targets: ["DajetUI"]),
        .executable(name: "DajetUIDemo", targets: ["DajetUIDemo"]),
    ],
    targets: [
        .target(
            name: "DajetUI",
            swiftSettings: [.swiftLanguageMode(.v5)]
        ),
        .executableTarget(
            name: "DajetUIDemo",
            dependencies: ["DajetUI"],
            swiftSettings: [.swiftLanguageMode(.v5)]
        ),
        .testTarget(
            name: "DajetUITests",
            dependencies: ["DajetUI"],
            swiftSettings: [.swiftLanguageMode(.v5)]
        ),
    ]
)

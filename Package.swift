// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "NotchNook",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .executable(
            name: "NotchNook",
            targets: ["NotchNook"]
        )
    ],
    dependencies: [],
    targets: [
        .executableTarget(
            name: "NotchNook",
            dependencies: [],
            path: "Sources"
        )
    ]
)


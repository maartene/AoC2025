// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Day10",
    platforms: [
        .macOS(.v26)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .executable(
            name: "Day10",
            targets: ["Day10"]
        )
    ],
    dependencies: [
        .package(name: "Shared", path: "../Shared"),
        .package(url: "https://github.com/apple/swift-algorithms", from: "1.2.0"),
        .package(
              url: "https://github.com/apple/swift-collections.git",
              .upToNextMinor(from: "1.3.0") // or `.upToNextMajor
            ),
        .package(url: "https://github.com/LuizZak/swift-z3.git", revision: "872e516feb689f17a2fcd5fe32b344dabdb9074b")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "Day10",
            dependencies: [
                "Shared",
                .product(name: "Algorithms", package: "swift-algorithms"),
                .product(name: "Collections", package: "swift-collections"),
                .product(name: "SwiftZ3", package: "swift-z3")
            ]
        ),
        .testTarget(
            name: "Day10Tests",
            dependencies: ["Day10"]
        ),
    ]
)


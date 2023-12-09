// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "CanonicalPackageURL",
    platforms: [.macOS(.v10_15)],
    products: [
        .library(
            name: "CanonicalPackageURL",
            targets: ["CanonicalPackageURL"]),
    ],
    dependencies: [
        // pin swift-case-paths to pre-macros, avoid pulling in swift-syntax, which causes link errors
        .package(url: "https://github.com/pointfreeco/swift-case-paths.git", revision: "1.0.0"),
        .package(url: "https://github.com/pointfreeco/swift-parsing.git", from: "0.12.0")
    ],
    targets: [
        .target(
            name: "CanonicalPackageURL",
            dependencies: [
                .product(name: "Parsing", package: "swift-parsing")
            ]
        ),
        .testTarget(name: "CanonicalPackageURLTests", dependencies: ["CanonicalPackageURL"]),
    ]
)

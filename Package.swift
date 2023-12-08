// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "CanonicalPackageURLs",
    platforms: [.macOS(.v10_15)],
    products: [
        .library(
            name: "CanonicalPackageURLs",
            targets: ["CanonicalPackageURLs"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-case-paths.git", revision: "1.0.0"),
        .package(url: "https://github.com/pointfreeco/swift-parsing.git", from: "0.12.0")
    ],
    targets: [
        .target(
            name: "CanonicalPackageURLs",
            dependencies: [
                .product(name: "Parsing", package: "swift-parsing")
            ]
        ),
        .testTarget(name: "CanonicalPackageURLsTests", dependencies: ["CanonicalPackageURLs"]),
    ]
)

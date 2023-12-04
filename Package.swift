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
        .package(url: "https://github.com/pointfreeco/swift-parsing", revision: "0.12.0")
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

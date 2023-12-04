// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "CanonicalPackageURLs",
    products: [
        .library(
            name: "CanonicalPackageURLs",
            targets: ["CanonicalPackageURLs"]),
    ],
    targets: [
        .target(
            name: "CanonicalPackageURLs"),
        .testTarget(
            name: "CanonicalPackageURLsTests",
            dependencies: ["CanonicalPackageURLs"]),
    ]
)

// swift-tools-version: 5.8

// Copyright Dave Verwer, Sven A. Schmidt, and other contributors.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

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

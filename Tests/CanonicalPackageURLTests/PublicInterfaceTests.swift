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

import XCTest

import CanonicalPackageURL


final class PublicInterfaceTests: XCTestCase {

    func test_init() throws {
        XCTAssertEqual(CanonicalPackageURL("http://github.com/apple/swift-argument-parser"),
                       .init(prefix: .http, hostname: "github.com", path: "apple/swift-argument-parser"))
    }

}

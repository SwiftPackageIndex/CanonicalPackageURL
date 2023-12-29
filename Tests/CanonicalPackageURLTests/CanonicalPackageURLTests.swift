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
@testable import CanonicalPackageURL


typealias Prefix = CanonicalPackageURL.Prefix

final class CanonicalPackageURLsTests: XCTestCase {

    func test_Prefix_parsing() throws {
        XCTAssertEqual(try Prefix.parser(of: .gitAt).parse("git@"), .gitAt)
        XCTAssertEqual(try Prefix.parser(of: .gitAt).parse("GIT@"), .gitAt)
        XCTAssertEqual(try Prefix.parser(of: .gitAt).parse("Git@"), .gitAt)
        XCTAssertThrowsError(try Prefix.parser(of: .gitAt).parse("git"))
    }

    func test_Prefix_description() throws {
        XCTAssertEqual(Prefix.gitAt.description, "git@")
        XCTAssertEqual(Prefix.http.description, "http")
        XCTAssertEqual(Prefix.https.description, "https")
    }

    func test_Prefix_matcher() throws {
        XCTAssertEqual(Prefix.gitAt.matcher, "git@")
        XCTAssertEqual(Prefix.http.matcher, "http://")
        XCTAssertEqual(Prefix.https.matcher, "https://")
    }

    func test_parser() throws {
        XCTAssertEqual(try CanonicalPackageURL.parser.parse("git@github.com:andtie/SequenceBuilder.git"),
                       .init(prefix: .gitAt, hostname: "github.com", path: "andtie/SequenceBuilder"))
        XCTAssertEqual(try CanonicalPackageURL.parser.parse("http://github.com/apple/swift-argument-parser"),
                       .init(prefix: .http, hostname: "github.com", path: "apple/swift-argument-parser"))
        XCTAssertEqual(try CanonicalPackageURL.parser.parse("https://gitee.com/zexu007/Kingfisher.git"),
                       .init(prefix: .https, hostname: "gitee.com", path: "zexu007/Kingfisher"))
    }

    func test_parser_malformedInput() throws {
        // triple slash
        XCTAssertEqual(try CanonicalPackageURL.parser.parse("https:///github.com/apple/swift-system.git"),
                       .init(prefix: .https, hostname: "github.com", path: "apple/swift-system"))
        XCTAssertEqual(try CanonicalPackageURL.parser.parse("http:///github.com/apple/swift-system.git"),
                       .init(prefix: .http, hostname: "github.com", path: "apple/swift-system"))
        // quadruple slash
        XCTAssertEqual(try CanonicalPackageURL.parser.parse("https:////github.com/apple/swift-system.git"),
                       .init(prefix: .https, hostname: "github.com", path: "apple/swift-system"))
        XCTAssertEqual(try CanonicalPackageURL.parser.parse("http:////github.com/apple/swift-system.git"),
                       .init(prefix: .http, hostname: "github.com", path: "apple/swift-system"))
        // bad (but salvageable) git@ url
        XCTAssertEqual(try CanonicalPackageURL.parser.parse("git@/github.com/apple/swift-system.git"),
                       .init(prefix: .gitAt, hostname: "github.com", path: "apple/swift-system"))
    }

}

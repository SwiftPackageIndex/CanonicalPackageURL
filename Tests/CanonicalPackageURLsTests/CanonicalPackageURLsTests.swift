import XCTest
@testable import CanonicalPackageURLs

final class CanonicalPackageURLsTests: XCTestCase {

    func test_parser() throws {
        XCTAssertEqual(try CanonicalPackageURL.parser.parse("git@github.com:andtie/SequenceBuilder.git"),
                       .init(prefix: .gitAt, hostname: "github.com", path: "andtie/SequenceBuilder"))
        XCTAssertEqual(try CanonicalPackageURL.parser.parse("http://github.com/apple/swift-argument-parser"),
                       .init(prefix: .http, hostname: "github.com", path: "apple/swift-argument-parser"))
        XCTAssertEqual(try CanonicalPackageURL.parser.parse("https://gitee.com/zexu007/Kingfisher.git"),
                       .init(prefix: .https, hostname: "gitee.com", path: "zexu007/Kingfisher"))
    }

}

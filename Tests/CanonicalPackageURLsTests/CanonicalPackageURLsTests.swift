import XCTest
@testable import CanonicalPackageURLs


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

}

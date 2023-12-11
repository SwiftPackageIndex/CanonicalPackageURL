import XCTest

import CanonicalPackageURL


final class PublicInterfaceTests: XCTestCase {

    func test_init() throws {
        XCTAssertEqual(CanonicalPackageURL("http://github.com/apple/swift-argument-parser"),
                       .init(prefix: .http, hostname: "github.com", path: "apple/swift-argument-parser"))
    }

}

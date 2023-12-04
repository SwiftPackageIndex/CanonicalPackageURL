import Parsing


struct CanonicalPackageURL: Equatable {
    var prefix: Prefix
    var hostname: String
    var path: String

    enum Prefix: String, CustomStringConvertible {
        case gitAt = "git@"
        case http = "http"
        case https = "https"

        static func parser(of prefix: Prefix) -> some Parser<Substring, Prefix> {
            Parse {
                PrefixUpTo(prefix.matcher) { $0.lowercased() == $1.lowercased() }
                StartsWith(prefix.matcher) { $0.lowercased() == $1.lowercased() }
            }
            .map { _ in prefix }
        }
        var description: String { rawValue }
        var matcher: String {
            switch self {
                case .gitAt:
                    return rawValue
                case .http:
                    return rawValue + "://"
                case .https:
                    return rawValue + "://"
            }
        }
    }

    static var hostname: some Parser<Substring, String> {
        Parse {
            OneOf {
                PrefixUpTo(":")
                PrefixUpTo("/")
            }.map(.string)
            Skip { OneOf { ":"; "/" } }
        }
    }

    static var suffix: some Parser<Substring, String> {
        OneOf {
            Parse {
                PrefixUpTo(".git") { $0.lowercased() == $1.lowercased() }
                StartsWith(".git") { $0.lowercased() == $1.lowercased() }
            }
            Rest()
        }.map(.string)
    }

    static var parser: some Parser<Substring, Self> {
        Parse {
            OneOf {
                Prefix.parser(of: .gitAt)
                Prefix.parser(of: .http)
                Prefix.parser(of: .https)
            }
            hostname
            suffix
        }
        .map(Self.init(prefix:hostname:path:))
    }
}

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

import Parsing


public struct CanonicalPackageURL: Codable, Equatable {
    public var prefix: Prefix
    public var hostname: String
    public var path: String

    public init(prefix: CanonicalPackageURL.Prefix, hostname: String, path: String) {
        self.prefix = prefix
        self.hostname = hostname
        self.path = path
    }

    public init?(_ string: String) {
        do {
            self = try Self.parser.parse(string)
        } catch {
            return nil
        }
    }

    public var canonicalPath: String { path.lowercased() }
}


//MARK: Prefix

extension CanonicalPackageURL {
    public enum Prefix: String, Codable, CustomStringConvertible {
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
        public var description: String { rawValue }
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
}


//MARK: Parsers

extension CanonicalPackageURL {
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

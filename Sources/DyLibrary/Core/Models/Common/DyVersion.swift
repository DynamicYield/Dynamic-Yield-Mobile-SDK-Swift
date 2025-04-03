//
//  DyVersion.swift
//  DyLibrary
//
//  Created by Miri Kutainer on 24/11/2024.
//

class DyVersion {

    let versionPrefix = "swift"
    let major: String
    let minor: String
    let patch: String

    init(_ major: String, _ minor: String, _ patch: String) {
        self.major = major
        self.minor = minor
        self.patch = patch
    }

    public var description: String { return "\(versionPrefix)-\(major).\(minor).\(patch)" }
}

//
//  Cookie.swift
//  DYLibrary
//
//  Created by Miri Kutainer on 23/08/2023.
//

import Foundation

public struct Cookie: Codable {
    public let name: String
    public let value: String
    public let maxAge: String

    public init(name: String, value: String, maxAge: String) {
        self.name = name
        self.value = value
        self.maxAge = maxAge
    }
}

//
//  Warning.swift
//  DYLibrary
//
//  Created by Miri Kutainer on 23/08/2023.
//

import Foundation

public struct CodeWarning: Codable {
    public let code: String
    public let message: String

    public var description: String {
        "Warning(code: \(code), message: \(message))"
    }
}

//
//  SecondaryIdentifier.swift
//
//
//  Created by Miri Kutainer on 22/09/2024.
//

import Foundation

public struct SecondaryIdentifier: Encodable {
    let type: String
    let value: String

    public init(type: String, value: String) {
        self.type = type
        self.value = value
    }
}

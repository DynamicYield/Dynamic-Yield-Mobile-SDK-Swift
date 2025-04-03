//
//  Session.swift
//  DYLibrary
//
//  Created by Miri Kutainer on 23/08/2023.
//

import Foundation

public struct Session: Encodable {
    let dy: String?

    public init(dy: String?) {
        self.dy = dy
    }
}

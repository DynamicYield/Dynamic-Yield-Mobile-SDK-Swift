//
//  MessageOptOutEventProperties.swift
//  DYLibrary
//
//  Created by Miri Kutainer on 23/05/2024.
//

import Foundation

public struct PushOptOutProperties: EventProperties {
    public var dyType: String
    var pushId: String

    public init(pushId: String) {
        self.dyType = "message-optout-v1"
        self.pushId = pushId
    }
}

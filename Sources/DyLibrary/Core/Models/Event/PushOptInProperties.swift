//
//  MessageOptInProperties.swift
//  DYLibrary
//
//  Created by Miri Kutainer on 23/05/2024.
//

import Foundation

public struct PushOptInProperties: EventProperties {
    public var dyType: String
    var pushId: String

    public init(pushId: String) {
        self.dyType = "message-optin-v1"
        self.pushId = pushId
    }
}

//
//  MessageOptInProperties.swift
//  DYLibrary
//
//  Created by Miri Kutainer on 23/05/2024.
//

import Foundation

public struct MessageOptInEventProperties: EventProperties {
    public var dyType: String
    var cuidType: CuidType
    var plainTextEmail: String?
    var externalId: String?

    public init(cuidType: CuidType, plainTextEmail: String? = nil, externalId: String? = nil) {
        self.dyType = "message-optin-v1"
        self.cuidType = cuidType
        self.plainTextEmail = plainTextEmail
        self.externalId = externalId
    }
}

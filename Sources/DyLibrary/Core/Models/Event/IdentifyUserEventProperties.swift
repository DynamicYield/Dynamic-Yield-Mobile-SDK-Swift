//
//  IdentifyForKnownUserEventProperties.swift
//  DYLibrary
//
//  Created by Valeria Pivchik on 22/11/2023.
//

import Foundation

public struct IdentifyUserEventProperties: EventProperties {

    public var dyType: String
    var cuidType: String
    var cuid: String?
    var secondaryIdentifiers: [SecondaryIdentifier]?

    public init(cuidType: String, cuid: String? = nil, secondaryIdentifiers: [SecondaryIdentifier]? = nil) {
        self.dyType  = "identify-v1"
        self.cuidType = cuidType
        self.cuid = cuid
        self.secondaryIdentifiers = secondaryIdentifiers
    }
}

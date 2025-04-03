//
//  SignUpEventProperties.swift
//  DYLibrary
//
//  Created by Valeria Pivchik on 22/11/2023.
//

import Foundation

public struct SignUpEventProperties: EventProperties {

    public var dyType: String
    var cuidType: String?
    var cuid: String?
    var secondaryIdentifiers: [SecondaryIdentifier]?

    public init(cuidType: String? = nil, cuid: String? = nil, secondaryIdentifiers: [SecondaryIdentifier]? = nil) {
        self.dyType  = "signup-v1"
        self.cuidType = cuidType
        self.cuid = cuid
        self.secondaryIdentifiers = secondaryIdentifiers
    }
}

//
//  User.swift
//  DYLibrary
//
//  Created by Miri Kutainer on 23/08/2023.
//

import Foundation

public struct User: Encodable {
    let dyid: String?
    let sharedDevice: Bool?
    let cuid: String?
    let cuidType: String?
    // activeConsent is part of User, and will be serialized as true when sharedDevice is false

    enum CodingKeys: String, CodingKey {
        case dyid
        case sharedDevice
        case cuid
        case cuidType
        case activeConsent = "active_consent_accepted"
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if sharedDevice == true {
            try container.encodeIfPresent(true, forKey: .sharedDevice)
            try container.encodeIfPresent(self.cuid, forKey: .cuid)
            try container.encodeIfPresent(self.cuidType, forKey: .cuidType)
        } else {
            try container.encodeIfPresent(true, forKey: .activeConsent)
            try container.encodeIfPresent((dyid?.isEmpty ?? true) ? "" : dyid, forKey: .dyid)
            if sharedDevice != nil {
                try container.encode(false, forKey: .sharedDevice)
            }
        }
    }

    public init(dyid: String? = nil, sharedDevice: Bool? = nil, cuid: String? = nil, cuidType: String? = nil) {
        self.dyid = dyid
        self.sharedDevice = sharedDevice
        self.cuid = cuid
        self.cuidType = cuidType
    }
}

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

    enum CodingKeys: CodingKey {
        case dyid
        case sharedDevice
        case cuid
        case cuidType
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if sharedDevice != true {
            let dyidValue = (dyid?.isEmpty ?? true) ? "" : dyid
            try container.encodeIfPresent(dyidValue, forKey: .dyid)
        } else {
            try container.encodeIfPresent(self.sharedDevice, forKey: .sharedDevice)
            try container.encodeIfPresent(self.cuid, forKey: .cuid)
            try container.encodeIfPresent(self.cuidType, forKey: .cuidType)
        }
    }

    public init(dyid: String? = nil, sharedDevice: Bool? = nil, cuid: String? = nil, cuidType: String? = nil) {
        self.dyid = dyid
        self.sharedDevice = sharedDevice
        self.cuid = cuid
        self.cuidType = cuidType
    }
}

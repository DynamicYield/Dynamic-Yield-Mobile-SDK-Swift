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

    enum CodingKeys: CodingKey {
        case dyid
        case sharedDevice
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if sharedDevice != true {
            try container.encodeIfPresent(self.dyid, forKey: .dyid)
        }
        try container.encodeIfPresent(self.sharedDevice, forKey: .sharedDevice)
    }

    public init(dyid: String?, sharedDevice: Bool? = nil) {
        self.dyid = dyid
        self.sharedDevice = sharedDevice
    }
}

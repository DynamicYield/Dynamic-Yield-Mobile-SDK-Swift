//
//  Device.swift
//  DYLibrary
//
//  Created by Miri Kutainer on 23/08/2023.
//

import Foundation

public struct Device: Encodable {
    let type: DeviceType?
    let ip: String?
    let id: String?
    let addDateTime: Bool

    init(type: DeviceType? = nil, ip: String? = nil, id: String? = nil, addDateTime: Bool = true) {
        self.type = type
        self.ip = ip
        self.id = id
        self.addDateTime = addDateTime
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        if let type = type {
            try container.encode(type, forKey: .type)
        }

        if let ip = ip {
            try container.encode(ip, forKey: .ip)
        }

        if let id = id {
            try container.encode(id, forKey: .id)
        }
        // Custom encoding for date
        if addDateTime {
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withFullDate, .withFullTime, .withFractionalSeconds, .withColonSeparatorInTimeZone]
            formatter.timeZone = TimeZone.current

            try container.encode(formatter.string(from: Date()), forKey: .date)
        }
    }

    private enum CodingKeys: String, CodingKey {
        case ip
        case date = "dateTime"
        case type
        case id
    }
}

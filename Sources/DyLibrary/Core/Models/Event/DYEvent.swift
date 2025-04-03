//
//  DYEvent.swift
//  DYLibrary
//
//  Created by Valeria Pivchik on 22/11/2023.
//

import Foundation

/// Common protocol for `Properties` and `CustomProperties`
public protocol EventProperties: Encodable {}

/// Protocol for default events
public protocol PredefinedProperties: EventProperties {
    var dyType: String { get set }
}

/// Protocol for custom events
public protocol CustomProperties: EventProperties { }

public struct AnyDYEvent: Encodable {
    let event: DYEvent?

    public func encode(to encoder: Encoder) throws {
        try event?.encode(to: encoder)
    }
}

public class DYEvent: Encodable {
    var name: String
    var properties: EventProperties

    public init(eventName: String, properties: EventProperties) {
        self.name = eventName
        self.properties = properties
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(name, forKey: .name)
        try container.encode(properties, forKey: .properties)
    }

    private enum CodingKeys: String, CodingKey {
        case name
        case properties
    }
}

// MARK: - Custom Event

/// There is an example of custom event

struct DYCustomEvent: CustomProperties {
    var isVIP: Bool
}

struct DYCustomEventNew: CustomProperties {
    var customerRole: String
    var experienceRating: Int
    var likesSpecialOffers: Bool
}

//
//  Payload.swift
//
//
//  Created by Miri Kutainer on 16/09/2024.
//

import Foundation

public class Payload: Decodable {
    public let type: DecisionType
}

public class CustomJsonPayload: Payload {
    public var data: String

    // Custom initializer for CustomPayload
    public required init(from decoder: Decoder) throws {

        // Decode the additional property `data`
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let jsonDict = try? container.decodeIfPresent([String: AnyDecodable].self, forKey: .data) {
            let jsonData = try JSONSerialization.data(withJSONObject: jsonDict.mapValues { $0.value })
            self.data = String(data: jsonData, encoding: .utf8) ?? "{}"
        } else if let jsonArray = try? container.decode([AnyDecodable].self, forKey: .data) {
            let jsonData = try JSONSerialization.data(withJSONObject: jsonArray.map { $0.value })
            self.data = String(data: jsonData, encoding: .utf8) ?? "[]"
        } else {
            self.data = "{}" // Default empty JSON
        }

        try super.init(from: decoder)
    }

    // Enum to define the additional keys for CustomPayload
    enum CodingKeys: String, CodingKey {
        case data
    }
}

public class RecsPayload: Payload {
    public var data: RecsData

    public required init(from decoder: Decoder) throws {

        // Decode the additional property `data`
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode(RecsData.self, forKey: .data)

        // Decode the properties from the superclass first
        try super.init(from: decoder)
    }

    // Define the coding keys used for decoding
    enum CodingKeys: String, CodingKey {
        case data
    }
}

public class StoreRecsPayload: Payload {
    public let data: StoreRecsData

    public required init(from decoder: Decoder) throws {
        // Decode the properties from the superclass first

        // Decode the additional property `data`
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode(StoreRecsData.self, forKey: .data)
        try super.init(from: decoder)

    }

    // Define the coding keys used for decoding
    enum CodingKeys: String, CodingKey {
        case data
    }
}

public class RecsData: Decodable {
    public let custom: String
    public let slots: [RecsSlot]

    private enum CodingKeys: CodingKey {
        case custom
        case slots
    }

    public required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let jsonDict = try? container.decodeIfPresent([String: AnyDecodable].self, forKey: .custom) {
            let jsonData = try JSONSerialization.data(withJSONObject: jsonDict.mapValues { $0.value })
            self.custom = String(data: jsonData, encoding: .utf8) ?? "{}"
        } else if let jsonArray = try? container.decode([AnyDecodable].self, forKey: .custom) {
            let jsonData = try JSONSerialization.data(withJSONObject: jsonArray.map { $0.value })
            self.custom = String(data: jsonData, encoding: .utf8) ?? "[]"
        } else {
            self.custom = "{}" // Default empty JSON
        }
        self.slots = try container.decode([RecsSlot].self, forKey: .slots)

    }

}

public class StoreRecsData: Decodable {
    public let custom: String
    public let slots: [StoreRecsSlot]

    private enum CodingKeys: CodingKey {
        case custom
        case slots
    }

    public required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let jsonDict = try? container.decodeIfPresent([String: AnyDecodable].self, forKey: .custom) {
            let jsonData = try JSONSerialization.data(withJSONObject: jsonDict.mapValues { $0.value })
            self.custom = String(data: jsonData, encoding: .utf8) ?? "{}"
        } else if let jsonArray = try? container.decode([AnyDecodable].self, forKey: .custom) {
            let jsonData = try JSONSerialization.data(withJSONObject: jsonArray.map { $0.value })
            self.custom = String(data: jsonData, encoding: .utf8) ?? "[]"
        } else {
            self.custom = "{}" // Default empty JSON
        }
        self.slots = try container.decode([StoreRecsSlot].self, forKey: .slots)

    }

}

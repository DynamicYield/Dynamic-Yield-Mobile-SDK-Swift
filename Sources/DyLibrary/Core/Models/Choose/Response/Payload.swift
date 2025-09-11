//
//  Payload.swift
//
//
//  Created by Miri Kutainer on 16/09/2024.
//

import Foundation

public class Payload: Decodable {
    public let type: DecisionType

    init(type: DecisionType) {
        self.type = type
    }
}

public class CustomJsonPayload: Payload {
    public var data: String

    public required init(type: DecisionType, data: String) {
        self.data = data
        super.init(type: type)
    }

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

    init(type: DecisionType, data: RecsData) {
        self.data = data
        super.init(type: type)
    }

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

    init(type: DecisionType, data: StoreRecsData) {
        self.data = data
        super.init(type: type)
    }

    // Define the coding keys used for decoding
    enum CodingKeys: String, CodingKey {
        case data
    }
}

public class SortingPayload: Payload {
    public let data: SortingData

    public required init(from decoder: Decoder) throws {
        // Decode the properties from the superclass first

        // Decode the additional property `data`
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode(SortingData.self, forKey: .data)
        try super.init(from: decoder)

    }

    init(type: DecisionType, data: SortingData) {
        self.data = data
        super.init(type: type)
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

    init(custom: String, slots: [RecsSlot]) {
        self.custom = custom
        self.slots = slots
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

    init(custom: String, slots: [StoreRecsSlot]) {
        self.custom = custom
        self.slots = slots
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

public class SortingData: Decodable {
    public let slots: [SortingRecsSlot]

    private enum CodingKeys: CodingKey {
        case slots
    }

    public required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.slots = try container.decode([SortingRecsSlot].self, forKey: .slots)
    }

    init(slots: [SortingRecsSlot]) {
        self.slots = slots
    }

}

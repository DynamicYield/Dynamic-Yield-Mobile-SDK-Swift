//
//  SupportedValue.swift
//  DyLibrary
//
//  Created by Miri Kutainer on 30/07/2025.
//

import Foundation

public enum SupportedValue: Codable, Equatable {
    case string(String)
    case number(Double)
    case boolean(Bool)
    case array([SupportedValue])
    case map([String: SupportedValue])
    case null

    public func encode(to encoder: Encoder) throws {
        try encode(to: encoder, currentDepth: 0)
    }

    private func encode(to encoder: Encoder, currentDepth: Int) throws {
        guard currentDepth <= 100 else {
            throw EncodingPayloadError(source: "Maximum nesting depth of 100 exceeded")
        }

        var container = encoder.singleValueContainer()

        switch self {
        case .string(let value):
            try container.encode(value)
        case .number(let value):
            try container.encode(value)
        case .boolean(let value):
            try container.encode(value)
        case .null:
            try container.encodeNil()
        case .array(let array):
            var unkeyed = encoder.unkeyedContainer()
            for item in array {
                let nestedEncoder = unkeyed.superEncoder()
                try item.encode(to: nestedEncoder, currentDepth: currentDepth + 1)
            }
        case .map(let dict):
            var keyed = encoder.container(keyedBy: GenericCodingKey.self)
            for (key, value) in dict {
                let nestedEncoder = keyed.superEncoder(forKey: GenericCodingKey(key))
                try value.encode(to: nestedEncoder, currentDepth: currentDepth + 1)
            }
        }
    }

    public var stringValue: String? {
        if case .string(let value) = self { return value }
        return nil
    }

    public var numberValue: Double? {
        if case .number(let value) = self { return value }
        return nil
    }

    public var booleanValue: Bool? {
        if case .boolean(let value) = self { return value }
        return nil
    }

    public var arrayValue: [SupportedValue]? {
        if case .array(let value) = self { return value }
        return nil
    }

    public var mapValue: [String: SupportedValue]? {
        if case .map(let value) = self { return value }
        return nil
    }

    public var isNull: Bool {
        if case .null = self { return true }
        return false
    }
}

struct GenericCodingKey: CodingKey {
    let stringValue: String
    var intValue: Int? { nil }

    init(_ string: String) { self.stringValue = string }
    init?(stringValue: String) { self.stringValue = stringValue }
    init?(intValue: Int) { return nil }
}

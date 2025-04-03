//
//  AnyDecodable.swift
//  DyLibrary
//
//  Created by Miri Kutainer on 09/02/2025.
//
import Foundation
public struct AnyDecodable: Decodable {
    let value: Any?

    public init(from decoder: Decoder) throws {
        if let intValue = try? decoder.singleValueContainer().decode(Int.self) {
            value = intValue
        } else if let doubleValue = try? decoder.singleValueContainer().decode(Double.self) {
            value = NSDecimalNumber(value: doubleValue)
        } else if let boolValue = try? decoder.singleValueContainer().decode(Bool.self) {
            value = boolValue
        } else if let stringValue = try? decoder.singleValueContainer().decode(String.self) {
            value = stringValue
        } else if let dictValue = try? decoder.singleValueContainer().decode([String: AnyDecodable].self) {
            value = dictValue.mapValues { $0.value }
        } else if let arrayValue = try? decoder.singleValueContainer().decode([AnyDecodable].self) {
            value = arrayValue.map { $0.value }
        } else {
            value = nil
        }
    }
}

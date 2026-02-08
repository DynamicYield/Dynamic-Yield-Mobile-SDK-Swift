//
//  KeyedDecodingContainerExtensions.swift
//  DyLibrary
//
//  Created by Miri Kutainer on 13/11/2025.
//

import Foundation

extension KeyedDecodingContainer {
    func decodeCustomJSONAsString(forKey key: KeyedDecodingContainer<K>.Key) throws -> String? {
        if let jsonDict = try? self.decodeIfPresent([String: AnyDecodable].self, forKey: key) {
            let jsonData = try JSONSerialization.data(withJSONObject: jsonDict.mapValues { $0.value })
            return String(data: jsonData, encoding: .utf8) ?? "{}"
        } else if let jsonArray = try? self.decode([AnyDecodable].self, forKey: key) {
            let jsonData = try JSONSerialization.data(withJSONObject: jsonArray.map { $0.value })
            return String(data: jsonData, encoding: .utf8) ?? "[]"
        } else {
            return nil
        }
    }
}

//
//  EncodingManager.swift
//
//
//  Created by Miri Kutainer on 18/09/2024.
//

import Foundation

internal class EncodingManager {
    let logger = DYLogger(logCategory: "EncodingManager")

    internal func encode<T>(_ value: T) throws -> Data? where T: Encodable {
        logger.log(#function)
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = [.sortedKeys] // This preserves the manual order in `encode(to:)`
            return try encoder.encode(value)
        } catch {
            logger.log(logLevel: .error, error.localizedDescription)
            throw error
        }
    }
}

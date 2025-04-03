//
//  DecodingManager.swift
//
//
//  Created by Miri Kutainer on 18/09/2024.
//

import Foundation

internal class DecodingManager {
    private let logger = DYLogger(logCategory: "DecodingManager", logLevel: .error)

    internal func decodeFromString<T>(_ type: T.Type, from data: Data) throws -> T? where T: Decodable {
        logger.log(logLevel: .trace, #function)
        do {
            guard !data.isEmpty else {
                return nil
            }
            return try JSONDecoder().decode(type, from: data)
        } catch {
            self.handleDecodingError(error)
            throw error
        }
    }

    private func handleDecodingError(_ error: any Error) {
        if let decodingError = error as? DecodingError {
            switch decodingError {
            case .typeMismatch(let type, let context):
                logger.log("Type mismatch for type \(String(describing: type)). Coding Path: \(context.codingPath)")
            case .valueNotFound(let type, let context):
                logger.log("Value not found for type %@ \(String(describing: type)). Coding Path: \(context.codingPath)")
            case .keyNotFound(let key, let context):
                logger.log("Key '\(String(describing: key))' not found. Coding Path: \(context.codingPath)")
            case .dataCorrupted(let context):
                logger.log("Data corrupted: \(context.debugDescription). Coding Path: \(context.codingPath)")
            @unknown default:
                logger.log("Unknown decoding error:\(error.localizedDescription)")
            }
        }
    }

}

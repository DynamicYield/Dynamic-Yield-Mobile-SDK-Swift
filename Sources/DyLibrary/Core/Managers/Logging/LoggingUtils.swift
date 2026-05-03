//
//  LoggingStrings.swift
//  DyLibrary
//
//  Created by Avi Gelkop on 03/12/2024.
//

import Foundation

struct LoggingUtils {

    // MARK: - Safe Header Allow-list

    private static let safeHeaderKeys: Set<String> = [
        "content-type",
        "accept",
        "dy-sdk-version"
    ]

    private static let sensitiveHeaderKeys: Set<String> = [
        "dy-api-key"
    ]

    // MARK: - URL Sanitization

    /// Sanitizes URL by removing query parameters - returns only path
    static func sanitizeURL(_ urlString: String) -> String {
        guard let url = URL(string: urlString) else {
            return "[invalid-url]"
        }
        return url.path.isEmpty ? "/" : url.path
    }

    // MARK: - Header Sanitization

    /// Returns only safe headers for logging (allow-list approach)
    static func sanitizeHeaders(_ headers: [String: String]) -> [String: String] {
        var safeHeaders: [String: String] = [:]
        for (key, value) in headers {
            let lowercaseKey = key.lowercased()
            if safeHeaderKeys.contains(lowercaseKey) {
                safeHeaders[key] = value
            } else if sensitiveHeaderKeys.contains(lowercaseKey) {
                safeHeaders[key] = "[REDACTED]"
            }
            // Other headers are omitted entirely
        }
        return safeHeaders
    }

    /// Format sanitized headers for logging
    static func formatSafeHeaders(_ headers: [String: String]) -> String {
        let sanitized = sanitizeHeaders(headers)
        if sanitized.isEmpty {
            return "[no-safe-headers]"
        }
        return sanitized.map { "\($0.key): \($0.value)" }.joined(separator: ", ")
    }

    // MARK: - Init Log Messages (Debug Only)

    static func initLogMessage(_ type: Any.Type) -> String {
        "\(type) initialized"
    }

    static func sdkNotInitializedLogMessage(_ functionSignature: String) -> String {
        "\(functionSignature) Failed. SDK is not initialized"
    }

}

//  NetworkFailedError.swift
//
//
//  Created by Miri Kutainer on 22/09/2024.
//

import Foundation

public class NetworkFailedError: Error, CustomStringConvertible {
    public let url: String?
    public let code: Int?
    public let body: String?

    init(url: String?, code: Int?, body: Data) {
        self.url = url
        self.code = code
        self.body = String(data: body, encoding: .utf8)
    }

    public var description: String {
        let bodyString = body?.isEmpty == true ? "unknown" : (body ?? "unknown")
        return "Request for url: \(url ?? "unknown") failed with code \(code?.description ?? "unknown"). Response data: \(bodyString)"
    }
}

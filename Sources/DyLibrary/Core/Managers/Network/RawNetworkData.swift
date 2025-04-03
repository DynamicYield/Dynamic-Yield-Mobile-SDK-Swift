//
//  RawNetworkData.swift
//
//
//  Created by Miri Kutainer on 17/09/2024.
//

import Foundation

public struct RawNetworkData {
    public let request: URLRequest
    public let urlResponse: URLResponse
    public let code: Int
    public let isSuccessful: Bool
    public let body: Data
}

//
//  NetworkRequest.swift
//
//
//  Created by Miri Kutainer on 17/09/2024.
//

import Foundation

protocol NetworkRequest {

    func getRequest(
        url: String,
        method: HttpMethod,
        payload: Data?,
        headers: [String: String]) async throws -> RawNetworkData
}

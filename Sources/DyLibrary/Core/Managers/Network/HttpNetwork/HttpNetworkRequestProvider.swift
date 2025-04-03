//
//  HttpNetworkRequestProvider.swift
//  DyLibrary
//
//  Created by Miri Kutainer on 02/12/2024.
//

import Foundation

struct HttpNetworkRequestProvider: NetworkRequestProvider {
    func create(timeoutInterval: TimeInterval?) -> HttpNetwork {
        return HttpNetwork(timeoutInterval, urlSession: URLSession.shared)
    }
}

//
//  HttpNetworkRequestProvider.swift
//  DyLibrary
//
//  Created by Miri Kutainer on 02/12/2024.
//

import Foundation

struct HttpNetworkRequestProvider: NetworkRequestProvider {

    /// Private ephemeral URLSession for SDK network requests.

    private static let ephemeralSession: URLSession = {
        // Creates a configuration that stores no data to disk (RAM only).
        let configuration = URLSessionConfiguration.ephemeral
        // Disables the cache entirely so every request fetches fresh data from the server.
        configuration.urlCache = nil
        // Removes the persistent storage where the session would normally save cookies.
        configuration.httpCookieStorage = nil
        return URLSession(configuration: configuration)
    }()

    func create(timeoutInterval: TimeInterval?) -> HttpNetwork {
        return HttpNetwork(timeoutInterval, urlSession: HttpNetworkRequestProvider.ephemeralSession)
    }
}

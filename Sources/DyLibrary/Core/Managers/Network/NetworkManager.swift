//
//  NetworkManager.swift
//
//
//  Created by Miri Kutainer on 17/09/2024.
//

import Foundation

class NetworkManager {
    internal let apiKey: String
    private let dyVersion: DyVersion
    internal var timeout: TimeInterval?

    private let logger = DYLogger(logCategory: "NetworkManager")

    init(apiKey: String, dyVersion: DyVersion) {
        logger.log(LoggingUtils.initLogMessage(type(of: self)))
        self.apiKey = apiKey
        self.dyVersion = dyVersion
    }

    func sendRequest(endpointModel: EndpointModelProtocol, networkRequestProvider: any NetworkRequestProvider) async throws -> RawNetworkData {
        logger.log(#function)

        let result: RawNetworkData = try await networkRequestProvider.create(timeoutInterval: timeout).getRequest(
            url: endpointModel.url,
            method: endpointModel.httpMethod,
            payload: endpointModel.getPayload(),
            headers: getHeaders())

        if !result.isSuccessful {
            logger.log(logLevel: .debug, endpointModel.getNetworkFailureMessage())
        }

        return result
    }

    func getHeaders() -> [String: String] {
        logger.log(#function)

        return [EndpointModelUtils.acceptHeader: EndpointModelUtils.applicationJson,
         EndpointModelUtils.contentTypeHeader: EndpointModelUtils.applicationJson,
         EndpointModelUtils.dyApiKey: apiKey,
         EndpointModelUtils.dySdkVersionHeader: dyVersion.description]
    }
}

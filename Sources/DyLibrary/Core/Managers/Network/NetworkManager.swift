//
//  NetworkManager.swift
//
//
//  Created by Miri Kutainer on 17/09/2024.
//

import Foundation

class NetworkManager {
    internal let apiKey: String
    private var dyVersion: String
    internal var timeout: TimeInterval?
    private var initilized: Bool

    private let logger = DYLogger(logCategory: "NetworkManager")

    init(apiKey: String, dyVersion: String, initialized: Bool) {
        logger.log(LoggingUtils.initLogMessage(type(of: self)))
        self.apiKey = apiKey
        self.dyVersion = dyVersion
        self.initilized = initialized
    }

    func sendRequest(endpointModel: EndpointModelProtocol, networkRequestProvider: any NetworkRequestProvider) async throws -> RawNetworkData {

        guard initilized else {
            logger.log(logLevel: .critical, LoggingUtils.sdkNotInitializedLogMessage(#function))
            throw InitializeError.init(isInitialize: false)
        }

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
         EndpointModelUtils.dySdkVersionHeader: dyVersion]
    }

    // swiftlint:disable:next identifier_name
    internal func _setHeaderInternalUse(dyVersion: String) {
        self.dyVersion = dyVersion
    }
}

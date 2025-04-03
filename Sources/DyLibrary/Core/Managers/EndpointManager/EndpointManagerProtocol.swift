//
//  EndpointManagerProtocol.swift
//
//
//  Created by Miri Kutainer on 17/09/2024.
//

import Foundation

protocol EndpointManagerProtocol {
    var endpointManagerProvider: EndpointManagerProvider { get }
    var encodingManager: EncodingManager { get }
    var decodingManager: DecodingManager { get }
    var endpointModelProvider: EndpointModelProvider { get }
    var logCategory: String { get }

    var logger: DYLogger { get }

    func sendRequest(endpoint: EndpointModelProtocol) async -> DYResult
    func getWarnings(body: Data?) throws -> [Warning]?
}

extension EndpointManagerProtocol {
    var endpointModelProvider: EndpointModelProvider {
        EndpointModelProviderImplementation(
            getSession: {
                endpointManagerProvider.getSession()
            },
            getUser: {
                endpointManagerProvider.getUser()
            },
            getExperienceConfig: {
                endpointManagerProvider.getExperienceConfig()
            },
            encodingPayload: { payload in
                return try encodingManager.encode(payload)
            },
            decodingWarnings: { data in
                return try getWarnings(body: data)
            }
        )
    }

    func sendRequest(endpoint: EndpointModelProtocol) async -> DYResult {
        logger.log(#function)
        var rawNetworkData: RawNetworkData?
        var warnings: [Warning]?
        var resultError: Error?
        var code: Int?
        do {
            let networkResult = try await endpointManagerProvider.sendRequest(endpointModel: endpoint)
            rawNetworkData = networkResult
            code = rawNetworkData?.code
            warnings = (rawNetworkData?.isSuccessful == true) ? try endpoint.getWarnings(body: rawNetworkData?.body) : nil
            resultError = endpoint.checkNetworkError(
                url: endpoint.url,
                code: code,
                body: networkResult.body
            )
        } catch {
            resultError = error
        }
        let status: ResultStatus = endpoint.getStatus(code: code, warning: warnings, error: resultError)
        logger.log("Status is: \(status), warnings are: \(String(describing: warnings)), error is: \(String(describing: resultError?.localizedDescription))")
        return DYResult(status: status,
                        warnings: warnings,
                        error: resultError,
                        rawNetworkData: rawNetworkData)

    }
}

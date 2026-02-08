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

    func sendRequest<P: ResponseProvider>(
        endpoint: EndpointModelProtocol,
        campaignResponseProvider: P
    ) async -> P.ResultType where P.ResponseType: Response, P.ResultType: DYResult

    func getWarnings(body: Data?) throws -> [Warning]?
}

extension EndpointManagerProtocol {
    var endpointModelProvider: EndpointModelProvider {
        EndpointModelProviderImplementation(
            getSession: {
                endpointManagerProvider.getSession()
            },
            getUser: { cuid, cuidType in
                endpointManagerProvider.getUser(cuid: cuid, cuidType: cuidType)
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

    func sendRequest<P: ResponseProvider>(
        endpoint: EndpointModelProtocol,
        campaignResponseProvider: P
    ) async -> P.ResultType where P.ResponseType: Response, P.ResultType: DYResult {
        logger.log(#function)

        var rawNetworkData: RawNetworkData?
        var warnings: [Warning]?
        var resultError: Error?
        var code: Int?
        do {
            var failedToUpdateCookies = false
            let networkResult = try await endpointManagerProvider.sendRequest(endpointModel: endpoint)
            rawNetworkData = networkResult
            if networkResult.isSuccessful == true {
                if campaignResponseProvider.hasBody() {
                    try campaignResponseProvider.decodingFromData(data: networkResult.body, decodingManager: decodingManager)
                }
                if campaignResponseProvider.hasCookies() {
                    if campaignResponseProvider.getCookies() != nil {
                        let result = endpointManagerProvider.updateCookies(cookies: campaignResponseProvider.getCookies())
                        if result == false {
                            failedToUpdateCookies = true
                        }
                    } else {
                        failedToUpdateCookies = true
                    }
                }
            }

            code = rawNetworkData?.code

            warnings = (networkResult.isSuccessful == true) ? try endpoint.getWarnings(body: networkResult.body) : nil

            if failedToUpdateCookies {
                warnings = (warnings ?? []) + [Warning(message: "Failed to write dy-id & session id to local app storage")]
            }

            resultError = endpoint.checkNetworkError(
                url: endpoint.url,
                code: code,
                body: networkResult.body
            )

        } catch {
            logger.log(logLevel: .error, "Send request failed: \(error.localizedDescription)")
            resultError = error
        }
        let status: ResultStatus = endpoint.getStatus(code: code, warning: warnings, error: resultError)

        logger.log("Status is: \(status), warnings are: \(String(describing: warnings)), error is: \(String(describing: resultError?.localizedDescription))")

        return campaignResponseProvider.getDYResult(
            status: status,
            warnings: warnings,
            error: resultError,
            rawNetworkData: rawNetworkData
        )
    }
}

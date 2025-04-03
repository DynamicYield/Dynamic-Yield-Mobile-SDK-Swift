//
//  ChooseManager.swift
//
//
//  Created by Miri Kutainer on 17/09/2024.
//

import Foundation

/// Manages the Choose API, sends requests, and returns results.
///

public class ChooseManager: EndpointManagerProtocol {
    var logger: DYLogger

    let endpointManagerProvider: EndpointManagerProvider
    var encodingManager = EncodingManager()
    var decodingManager = DecodingManager()
    var logCategory = "Choose Manager"

    // MARK: Init

    init(endpointManagerProvider: EndpointManagerProvider) {
        self.endpointManagerProvider = endpointManagerProvider
        logger = DYLogger(logCategory: logCategory)
        logger.log(LoggingUtils.initLogMessage(type(of: self)))
    }

    private func decodingChooseResponse(body: Data?) throws -> ChooseResponse? {
        guard let data = body else {
            logger.log(logLevel: .error, "decodingChooseResponse: body is nil")
            return nil
        }

        logger.log("Decoding choose response for body: \(String(describing: String(data: data, encoding: .utf8)))")
        do {
            return try decodingManager.decodeFromString(ChooseResponse.self, from: data)
        } catch {
            logger.log(logLevel: .error, "Failed to decode choose response")
            throw DecodingChooseResultError(sourceError: error)
        }
    }

    // MARK: API

    public func chooseVariations(
        selectorNames: [String]? = nil,
        page: Page,
        selectorGroups: [String]? = nil,
        selectorPreviews: [String]? = nil,
        dayPart: DayPart? = nil,
        cart: [CartItem]? = nil,
        branchId: String? = nil,
        options: ChooseOptions? = nil,
        pageAttributes: [String: PageAttribute]? = nil,
        recsProductData: RecsProductDataOptions? = nil,
        listedItems: [String]? = nil
    ) async -> DYChooseResult {
        logger.log("Choosing variations for page \(page.location)")

        if !endpointManagerProvider.isSdkInitialized() {
            logger.log(logLevel: .critical, LoggingUtils.sdkNotInitializedLogMessage(#function))

            return DYChooseResult(choices: nil, status: ResultStatus.error, warning: nil, error: InitializeError(isInitialize: false), rawNetworkData: nil)
        }

        let endpoint = ChooseModel(
            endpointModelProvider: endpointModelProvider,
            selectorNames: selectorNames,
            page: page,
            selectorGroups: selectorGroups,
            selectorPreviews: selectorPreviews,
            dayPart: dayPart,
            cart: cart,
            branchId: branchId,
            options: options,
            pageAttributes: pageAttributes,
            recsProductData: recsProductData,
            listedItems: listedItems
        )

        return await sendRequest(endpoint: endpoint)
    }

    // MARK: Override methods

    func sendRequest(endpoint: any EndpointModelProtocol) async -> DYChooseResult {
        logger.log(#function)

        var rawNetworkData: RawNetworkData?
        var chooseResponse: ChooseResponse?
        var warnings: [Warning]?
        let resultError: Error?

        do {
            var failedToUpdateCookies = false
            let networkResult = try await endpointManagerProvider.sendRequest(endpointModel: endpoint)
            rawNetworkData = networkResult
            if networkResult.isSuccessful == true {
                chooseResponse = try decodingChooseResponse(body: networkResult.body)
                if chooseResponse?.cookies != nil {
                    let result = endpointManagerProvider.updateCookies(cookies: chooseResponse?.cookies)
                    if result == false {
                        failedToUpdateCookies = true
                    }
                } else {
                    failedToUpdateCookies = true
                }
            }

            warnings = (networkResult.isSuccessful == true) ? try endpoint.getWarnings(body: networkResult.body) : nil

            if failedToUpdateCookies {
                warnings = (warnings ?? []) + [Warning(message: "Failed to write dy-id & session id to local app storage")]
            }

            resultError = endpoint.checkNetworkError(
                url: endpoint.url,
                code: networkResult.code,
                body: networkResult.body
            )
        } catch {
            logger.log(logLevel: .error, "Choose failed: \(error.localizedDescription)")
            resultError = error
        }

        let status = endpoint.getStatus(code: rawNetworkData?.code, warning: warnings, error: resultError)

        logger.log(logLevel: .info, "Choose success: choices are: \(String(describing: chooseResponse?.choices)), status is: \(status), warnings are: \(String(describing: warnings))")

        return DYChooseResult(
            choices: chooseResponse?.choices,
            status: status,
            warning: warnings,
            error: resultError,
            rawNetworkData: rawNetworkData)
    }

    func getWarnings(body: Data?) throws -> [Warning]? {
        logger.log(#function)

        guard let data = body else {
            return nil
        }

        do {
            return try decodingManager.decodeFromString(CodeAndMessageWarnings.self, from: data)?.warnings?.map { Warning(code: $0.code, message: $0.message)}
        } catch {
            logger.log(logLevel: .error, "Failed to decode warnings")
            throw error
        }
    }
}

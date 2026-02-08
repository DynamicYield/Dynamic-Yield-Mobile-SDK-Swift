//
//  AssistantManager.swift
//  DyLibrary
//
//  Created by Avi Gelkop on 15/09/2025
//

import Foundation

/// Manages Assistant endpoint interactions and state.
public class AssistantManager: EndpointManagerProtocol {
    var logger: DYLogger

    let endpointManagerProvider: EndpointManagerProvider
    var encodingManager = EncodingManager()
    var decodingManager = DecodingManager()

    var logCategory: String = "Assistant Manager"

    init(endpointManagerProvider: EndpointManagerProvider) {
        self.endpointManagerProvider = endpointManagerProvider
        logger = DYLogger(logCategory: logCategory)
        logger.log(LoggingUtils.initLogMessage(type(of: self)))
    }

    // MARK: API

    /// Requests Assistant variations for a given page and context.
    public func chatWithAssistant(
        page: Page,
        text: String,
        chatId: String? = nil,
        pageAttributes: [String: PageAttribute]? = nil,
        branchId: String? = nil,
        options: AssistantOptions? = nil
    ) async -> DYAssistantResult {
        logger.log("Chat response for text: \(text)")

        let endpoint = AssistantModel(
            endpointModelProvider: endpointModelProvider,
            page: page,
            branchId: branchId,
            options: options,
            pageAttributes: pageAttributes,
            text: text,
            chatId: chatId
        )

        return await sendRequest(endpoint: endpoint, campaignResponseProvider: AssistantResponseProvider())
    }

    // MARK: Override methods

    func getWarnings(body: Data?) throws -> [Warning]? {
        logger.log(#function)
        return try WarningsDecoder.decodeCodeAndMessageWarnings(body: body, decodingManager: decodingManager)
    }
}

//
//  SearchManager.swift
//
//
//  Created by Miri Kutainer on 17/09/2024.
//

import Foundation

/// Manages the Search API, sends requests, and returns results.
///

public class SearchManager: EndpointManagerProtocol {
    var logger: DYLogger

    let endpointManagerProvider: EndpointManagerProvider
    var encodingManager = EncodingManager()
    var decodingManager = DecodingManager()
    var logCategory = "Search Manager"

    // MARK: Init

    init(endpointManagerProvider: EndpointManagerProvider) {
        self.endpointManagerProvider = endpointManagerProvider
        logger = DYLogger(logCategory: logCategory)
        logger.log(LoggingUtils.initLogMessage(type(of: self)))
    }

    // MARK: API

    public func visualSearch(
        page: Page,
        imageBase64: String,
        filters: [Filter]? = nil,
        sortBy: SortOptions? = nil,
        pageAttributes: [String: PageAttribute]? = nil,
        branchId: String? = nil,
        options: SearchOptions? = nil
    ) async -> DYVisualSearchResult {
        logger.log("Visual search for page \(page.location)")

        let endpoint = SearchModel(
            endpointModelProvider: endpointModelProvider,
            page: page,
            query: SearchQuery.visualQuery(imageBase64, filters, sortBy),
            pageAttributes: pageAttributes,
            branchId: branchId,
            options: options
        )

        return await sendRequest(endpoint: endpoint, campaignResponseProvider: VisualSearchResponseProvider())
    }

    public func semanticSearch(
        page: Page,
        text: String,
        filters: [Filter]? = nil,
        pagination: Pagination,
        sortBy: SortOptions? = nil,
        pageAttributes: [String: PageAttribute]? = nil,
        branchId: String? = nil,
        options: SearchOptions? = nil
    ) async -> DYSemanticSearchResult {

        logger.log("Semantic search for page \(page.location)")

        let endpoint = SearchModel(
            endpointModelProvider: endpointModelProvider,
            page: page,
            query: SearchQuery.semanticQuery(text, filters, pagination, sortBy),
            pageAttributes: pageAttributes,
            branchId: branchId,
            options: options
        )

        return await sendRequest(endpoint: endpoint, campaignResponseProvider: SemanticSearchResponseProvider())
    }

    // MARK: Override methods

    func getWarnings(body: Data?) throws -> [Warning]? {
        logger.log(#function)
        return try WarningsDecoder.decodeCodeAndMessageWarnings(body: body, decodingManager: decodingManager)
    }
}

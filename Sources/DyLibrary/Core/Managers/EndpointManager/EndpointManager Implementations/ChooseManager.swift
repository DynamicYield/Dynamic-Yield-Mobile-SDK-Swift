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

    // MARK: API

    public func chooseVariations(
        selectorNames: [String]? = nil,
        page: Page,
        selectorGroups: [String]? = nil,
        selectorPreviews: [String]? = nil,
        dayPart: DayPart? = nil,
        cart: [CartItem]? = nil,
        branchId: String? = nil,
        orderFulfillment: OrderFulfillment? = nil,
        options: ChooseOptions? = nil,
        pageAttributes: [String: PageAttribute]? = nil,
        recsProductData: RecsProductDataOptions? = nil,
        listedItems: [String]? = nil,
        cuid: String? = nil,
        cuidType: String? = nil
    ) async -> DYChooseResult {
        logger.log("Choosing variations for page \(page.location)")

        let endpoint = ChooseModel(
            endpointModelProvider: endpointModelProvider,
            selectorNames: selectorNames,
            page: page,
            selectorGroups: selectorGroups,
            selectorPreviews: selectorPreviews,
            dayPart: dayPart,
            cart: cart,
            branchId: branchId,
            orderFulfillment: orderFulfillment,
            options: options,
            pageAttributes: pageAttributes,
            recsProductData: recsProductData,
            listedItems: listedItems,
            cuid: cuid,
            cuidType: cuidType
        )

        return await sendRequest(endpoint: endpoint, campaignResponseProvider: ChooseResponseProvider())
    }

    // MARK: Override methods

    func getWarnings(body: Data?) throws -> [Warning]? {
        logger.log(#function)
        return try WarningsDecoder.decodeCodeAndMessageWarnings(body: body, decodingManager: decodingManager)
    }
}

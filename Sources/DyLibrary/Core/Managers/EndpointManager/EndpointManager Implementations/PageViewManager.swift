//
//  PageViewManager.swift
//
//
//  Created by Miri Kutainer on 22/09/2024.
//

import Foundation

/// Manages the PageView API, sends requests, and returns results.
///
public class PageViewManager: EndpointManagerProtocol {
    var logger: DYLogger

    let endpointManagerProvider: EndpointManagerProvider

    var encodingManager = EncodingManager()

    var decodingManager = DecodingManager()

    var logCategory = "Pageview Manager"

    // MARK: Init

    init(endpointManagerProvider: EndpointManagerProvider) {
        self.endpointManagerProvider = endpointManagerProvider
        logger = DYLogger(logCategory: logCategory)
        logger.log(LoggingUtils.initLogMessage(type(of: self)))
    }

    // MARK: Override methods

    func getWarnings(body: Data?) throws -> [Warning]? {
        logger.log(#function)

        guard let data = body else {
            return nil
        }

        do {
            return try decodingManager.decodeFromString(StringWarnings.self, from: data)?.warnings?.map { Warning(message: $0)}
        } catch {
            logger.log(logLevel: .error, "Failed to decode warnings")
            throw error
        }
    }

    // MARK: Internal

    private func reportPageView(page: Page) async -> DYResult {
        logger.log(#function)

        if !endpointManagerProvider.isSdkInitialized() {
            logger.log(logLevel: .critical, LoggingUtils.sdkNotInitializedLogMessage(#function))
            return DYResult(status: ResultStatus.error, warnings: nil, error: InitializeError(isInitialize: false), rawNetworkData: nil)
        }

        let endpoint = PageViewModel(
            endpointModelProvider: endpointModelProvider,
            page: page
        )

        return  await sendRequest(endpoint: endpoint)
    }

    // MARK: API

    public func reportHomePageView(
        pageLocation: String,
        pageReferrer: String? = nil,
        pageLocale: String? = nil
    ) async -> DYResult {
        logger.log(#function)

        return await reportPageView(
            page: Page(
                type: PageType.homepage,
                location: pageLocation,
                referrer: pageReferrer,
                pageLocale: pageLocale
            )
        )
    }

    public func reportCategoryPageView(
        pageLocation: String,
        categories: [String],
        pageReferrer: String? = nil,
        pageLocale: String? = nil
    ) async -> DYResult {
        logger.log(#function)

        return await reportPageView(
            page: Page(
                type: PageType.category,
                location: pageLocation,
                data: categories,
                referrer: pageReferrer,
                pageLocale: pageLocale
            )
        )
    }

    public func reportProductPageView(
        pageLocation: String,
        sku: String,
        pageReferrer: String? = nil,
        pageLocale: String? = nil
    ) async -> DYResult {
        logger.log(#function)

        return await reportPageView(
            page: Page(
                type: PageType.product,
                location: pageLocation,
                data: [sku],
                referrer: pageReferrer,
                pageLocale: pageLocale
            )
        )
    }

    public func reportCartPageView(
        pageLocation: String,
        cart: [String],
        pageReferrer: String? = nil,
        pageLocale: String? = nil
    ) async -> DYResult {
        logger.log(#function)

        return await reportPageView(
            page: Page(
                type: PageType.cart,
                location: pageLocation,
                data: cart,
                referrer: pageReferrer,
                pageLocale: pageLocale
            )
        )
    }

    public func reportOtherPageView(
        pageLocation: String,
        pageReferrer: String? = nil,
        pageLocale: String? = nil,
        data: String
    ) async -> DYResult {
        logger.log(#function)

        return await reportPageView(
            page: Page(
                type: PageType.other,
                location: pageLocation,
                data: [data],
                referrer: pageReferrer,
                pageLocale: pageLocale
            )
        )
    }
}

//
//  EventsManager.swift
//
//
//  Created by Miri Kutainer on 22/09/2024.
//

import Foundation

/// Manages the Events API, sends requests, and returns results.
///
public class EventsManager: EndpointManagerProtocol {
    var logger: DYLogger

    let endpointManagerProvider: EndpointManagerProvider

    var encodingManager = EncodingManager()

    var decodingManager = DecodingManager()

    var logCategory = "Event Manager"

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
            return try decodingManager.decodeFromString(CodeAndMessageWarnings.self, from: data)?.warnings?.map { Warning(code: $0.code, message: $0.message)}
        } catch {
            logger.log(logLevel: .error, "Failed to decode warnings")
            throw error
        }
    }

    // MARK: API

    public func reportEvents(events: DYEvent...) async -> DYResult {
        logger.log(#function)

        if !endpointManagerProvider.isSdkInitialized() {
            logger.log(logLevel: .critical, LoggingUtils.sdkNotInitializedLogMessage(#function))
            return DYChooseResult(choices: nil, status: ResultStatus.error, warning: nil, error: InitializeError(isInitialize: false), rawNetworkData: nil)
        }

        let endpoint = EventModel(endpointModelProvider: endpointModelProvider, events: events)
        return  await sendRequest(endpoint: endpoint)
    }

    public func reportPromoCodeEnterEvent(
        eventName: String,
        code: String
    ) async -> DYResult {
        logger.log(#function)

        return await reportEvents(
            events: DYEvent(
                eventName: eventName,
                properties: PromoCodeEnterEventProperties(code: code)
            )
        )
    }

    public func reportAddToCartEvent(
        eventName: String,
        value: Float,
        currency: CurrencyType? = nil,
        productId: String,
        quantity: UInt,
        cart: [CartInnerItem]? = nil
    ) async -> DYResult {
        logger.log(#function)

        return await reportEvents(
            events: DYEvent(
                eventName: eventName,
                properties: AddToCartEventProperties(
                    value: value,
                    currency: currency,
                    productId: productId,
                    quantity: quantity,
                    cart: cart
                )
            )
        )
    }

    public func reportApplicationEvent(
        eventName: String,
        value: Float,
        currency: CurrencyType? = nil,
        productId: String,
        quantity: UInt,
        cart: [CartInnerItem]? = nil
    ) async -> DYResult {
        logger.log(#function)

        return await reportEvents(
            events: DYEvent(
                eventName: eventName,
                properties: AddToCartEventProperties(
                    value: value,
                    currency: currency,
                    productId: productId,
                    quantity: quantity,
                    cart: cart
                )
            )
        )
    }

    public func reportPurchaseEvent(
        eventName: String,
        value: Float,
        currency: CurrencyType? = nil,
        uniqueTransactionId: String? = nil,
        cart: [CartInnerItem]
    ) async -> DYResult {
        logger.log(#function)
        return await reportEvents(
            events: DYEvent(
                eventName: eventName,
                properties: PurchaseEventProperties(
                    value: value,
                    currency: currency,
                    uniqueTransactionId: uniqueTransactionId,
                    cart: cart
                )
            )
        )
    }

    public func reportSubmissionEvent(
        eventName: String,
        value: Float,
        currency: CurrencyType? = nil,
        uniqueTransactionId: String? = nil,
        cart: [CartInnerItem]
    ) async -> DYResult {
        logger.log(#function)
        return await reportEvents(
            events: DYEvent(
                eventName: eventName,
                properties: PurchaseEventProperties(
                    value: value,
                    currency: currency,
                    uniqueTransactionId: uniqueTransactionId,
                    cart: cart
                )
            )
        )
    }

    public func reportRemoveFromCartEvent(
        eventName: String,
        value: Float,
        currency: CurrencyType? = nil,
        productId: String,
        quantity: UInt,
        cart: [CartInnerItem]? = nil
    ) async -> DYResult {
        logger.log(#function)
        return await reportEvents(
            events: DYEvent(
                eventName: eventName,
                properties: RemoveFromCartEventProperties(
                    value: value,
                    currency: currency,
                    productId: productId,
                    quantity: quantity,
                    cart: cart
                )
            )
        )
    }

    public func reportSyncCartEvent(
        eventName: String,
        value: Float,
        currency: CurrencyType? = nil,
        cart: [CartInnerItem]
    ) async -> DYResult {
        logger.log(#function)
        return await reportEvents(
            events: DYEvent(
                eventName: eventName,
                properties: SyncCartEventProperties(cart: cart, value: value, currency: currency)
            )
        )
    }

    public func reportIdentifyUserEvent(
        eventName: String,
        cuidType: String,
        cuid: String? = nil,
        secondaryIdentifiers: [SecondaryIdentifier]? = nil
    ) async -> DYResult {
        logger.log(#function)
        return await reportEvents(
            events: DYEvent(
                eventName: eventName,
                properties: IdentifyUserEventProperties(
                    cuidType: cuidType,
                    cuid: cuid,
                    secondaryIdentifiers: secondaryIdentifiers
                )
            )
        )
    }

    public func reportLoginEvent(
        eventName: String,
        cuidType: String? = nil,
        cuid: String? = nil,
        secondaryIdentifiers: [SecondaryIdentifier]? = nil
    ) async -> DYResult {
        logger.log(#function)
        return await reportEvents(
            events: DYEvent(
                eventName: eventName,
                properties: LoginProperties(
                    cuidType: cuidType,
                    cuid: cuid,
                    secondaryIdentifiers: secondaryIdentifiers
                )
            )
        )
    }

    public func reportSignUpEvent(
        eventName: String,
        cuidType: String? = nil,
        cuid: String? = nil,
        secondaryIdentifiers: [SecondaryIdentifier]? = nil
    ) async -> DYResult {
        logger.log(#function)
        return await reportEvents(
            events: DYEvent(
                eventName: eventName,
                properties: SignUpEventProperties(
                    cuidType: cuidType,
                    cuid: cuid,
                    secondaryIdentifiers: secondaryIdentifiers
                )
            )
        )
    }

    public func reportNewsletterEvent(
        eventName: String,
        cuidType: String? = nil,
        cuid: String? = nil,
        secondaryIdentifiers: [SecondaryIdentifier]? = nil
    ) async -> DYResult {
        logger.log(#function)
        return await reportEvents(
            events: DYEvent(
                eventName: eventName,
                properties: NewsletterSubscriptionEventProperties(
                    cuidType: cuidType,
                    cuid: cuid,
                    secondaryIdentifiers: secondaryIdentifiers
                )
            )
        )
    }

    public func reportPushOptInEvent(
        eventName: String,
        pushId: String
    ) async -> DYResult {
        logger.log(#function)
        return await reportEvents(
            events: DYEvent(
                eventName: eventName,
                properties: PushOptInProperties(
                    pushId: pushId
                )
            )
        )
    }

    public func reportPushOptOutEvent(
        eventName: String,
        pushId: String
    ) async -> DYResult {
        logger.log(#function)
        return await reportEvents(
            events: DYEvent(
                eventName: eventName,
                properties: PushOptOutProperties(
                    pushId: pushId
                )
            )
        )
    }

    public func reportKeywordSearchEvent(
        eventName: String,
        keywords: String
    ) async -> DYResult {
        logger.log(#function)
        return await reportEvents(
            events: DYEvent(
                eventName: eventName,
                properties: KeywordSearchEventProperties(keywords: keywords)
            )
        )
    }

    public func reportAddToWishListEvent(
        eventName: String,
        productId: String,
        size: String? = nil
    ) async -> DYResult {
        logger.log(#function)
        return await reportEvents(
            events: DYEvent(
                eventName: eventName,
                properties: AddToWishListEventProperties(
                    productId: productId,
                    size: size
                )
            )
        )
    }

    public func reportFilterItemsEvent(
        eventName: String,
        filterType: String,
        filterNumericValue: Int? = nil,
        filterStringValue: String? = nil
    ) async -> DYResult {
        logger.log(#function)
        return await reportEvents(
            events: DYEvent(
                eventName: eventName,
                properties: FilterItemsEventProperties(
                    filterType: filterType,
                    filterNumericValue: filterNumericValue,
                    filterStringValue: filterStringValue
                )
            )
        )
    }

    public func reportChangeAttributesEvent(
        eventName: String,
        attributeType: String,
        attributeValue: String
    ) async -> DYResult {
        logger.log(#function)
        return await reportEvents(
            events: DYEvent(
                eventName: eventName,
                properties: ChangeAttributesEventProperties(
                    attributeType: attributeType,
                    attributeValue: attributeValue
                )
            )
        )
    }

    public func reportSortItemsEvent(
        eventName: String,
        sortBy: String,
        sortOrder: SortOrderType
    ) async -> DYResult {
        logger.log(#function)
        return await reportEvents(
            events: DYEvent(
                eventName: eventName,
                properties: SortItemEventProperties(
                    sortBy: sortBy,
                    sortOrder: sortOrder
                )
            )
        )
    }

    public func reportVideoWatchEvent(
        eventName: String,
        itemId: String,
        categories: [String]? = nil,
        autoplay: Bool,
        progress: VideoProgressType,
        progressPercent: UInt
    ) async -> DYResult {
        logger.log(#function)
        return await reportEvents(
            events: DYEvent(
                eventName: eventName,
                properties: VideoWatchEventProperties(
                    itemId: itemId,
                    categories: categories,
                    autoPlay: autoplay,
                    progress: progress,
                    progressPercent: progressPercent
                )
            )
        )
    }

    public func reportInformAffinityEvent(
        eventName: String,
        source: String? = nil,
        data: [InformAffinityData]
    ) async -> DYResult {
        logger.log(#function)
        return await reportEvents(
            events: DYEvent(
                eventName: eventName,
                properties: InformAffinityEventProperties(
                    source: source,
                    data: data
                )
            )
        )
    }

    public func reportCustomEvents(eventName: String, properties: CustomProperties) async -> DYResult {
        logger.log(#function)
        return await reportEvents(events: DYEvent(eventName: eventName, properties: properties))
    }

}

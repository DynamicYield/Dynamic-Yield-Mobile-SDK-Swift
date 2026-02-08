//
//  ChooseModel.swift
//
//
//  Created by Miri Kutainer on 17/09/2024.
//

import Foundation

/// Model class for Choose requests
///
public class ChooseModel: EndpointModelProtocol {
    var logger: DYLogger

    var endpointModelProvider: EndpointModelProvider
    private let selectorNames: [String]?
    private let page: Page
    private let selectorGroups: [String]?
    private let selectorPreviews: [String]?
    private let dayPart: DayPart?
    private let cart: [CartItem]?
    private let branchId: String?
    private let orderFulfillment: OrderFulfillment?
    private let options: ChooseOptions?
    private let pageAttributes: [String: PageAttribute]?
    private let recsProductData: RecsProductDataOptions?
    private let listedItems: [String]?
    private let cuid: String?
    private let cuidType: String?
    private let addDeviceDateTime: Bool

    public init(
        endpointModelProvider: EndpointModelProvider,
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
        addDeviceDateTime: Bool = true,
        cuid: String? = nil,
        cuidType: String? = nil
    ) {
        self.endpointModelProvider = endpointModelProvider
        self.selectorNames = selectorNames
        self.page = page
        self.selectorGroups = selectorGroups
        self.selectorPreviews  = selectorPreviews
        self.dayPart = dayPart
        self.cart = cart
        self.branchId = branchId
        self.orderFulfillment = orderFulfillment
        self.options = options
        self.pageAttributes = pageAttributes
        self.recsProductData = recsProductData
        self.listedItems = listedItems
        self.addDeviceDateTime = addDeviceDateTime
        self.cuid = cuid
        self.cuidType = cuidType
        logger = DYLogger(logCategory: logCategory)

        logger.log(LoggingUtils.initLogMessage(type(of: self)))
    }

    var httpMethod = HttpMethod.post

    var logCategory = "Choose Endpoint"

    var urlMethod = EndpointModelUtils.chooseUrl

    func encodingFailureMessage() -> String {
        "encode payload object for choose variation"
    }

    func getNetworkFailureMessage() -> String {
        "failed get Choose variations for choicesName: \(String(describing: selectorNames)) choicesGroups: \(String(describing: selectorGroups))"
    }

    public func getPayload() throws -> Data? {
        let device = Device(
            type: endpointModelProvider.getExperienceConfig().deviceType,
            ip: endpointModelProvider.getExperienceConfig().ip,
            id: endpointModelProvider.getExperienceConfig().deviceId,
            addDateTime: addDeviceDateTime
        )

        if page.locale == nil {
            page.locale = endpointModelProvider.getExperienceConfig().defaultLocale
        }

        let context = Context(
            page: page,
            device: device,
            branch: (dayPart != nil || branchId != nil || orderFulfillment != nil) ? Branch(
                id: branchId,
                dayPart: dayPart,
                orderFulfillment: orderFulfillment
            ) : nil,
            channel: endpointModelProvider.getExperienceConfig().channel,
            cart: cart,
            pageAttributes: pageAttributes,
            listedItems: listedItems
        )

        let selector = Selector(
            names: selectorNames,
            groups: selectorGroups,
            preview: selectorPreviews != nil ? Preview(ids: selectorPreviews) : nil)

        let currentImplicitPageview = options?.isImplicitPageview ?? endpointModelProvider.getExperienceConfig().isImplicitPageview
        let currentImplicitImpressionMode = options?.isImplicitImpressionMode ?? endpointModelProvider.getExperienceConfig().isImplicitImpressionMode

        let options = hasAnyNonNull(
            currentImplicitPageview,
            options?.returnAnalyticsMetadata,
            currentImplicitImpressionMode,
            recsProductData
        ) ?
        Options(
            isImplicitPageview: currentImplicitPageview,
            returnAnalyticsMetadata: options?.returnAnalyticsMetadata,
            isImplicitImpressionMode: currentImplicitImpressionMode,
            recsProductData: recsProductData
        ) : nil

        let choosePayloadData = ChoosePayload(
            session: endpointModelProvider.getSession(),
            user: endpointModelProvider.getUser(cuid: cuid, cuidType: cuidType),
            selector: selector,
            context: context,
            options: options
        )

        return try endpointModelProvider.encodingPayload(payload: choosePayloadData)
    }

    private func hasAnyNonNull(_ params: Any?...) -> Bool {
        params.contains { $0 != nil }
    }
}

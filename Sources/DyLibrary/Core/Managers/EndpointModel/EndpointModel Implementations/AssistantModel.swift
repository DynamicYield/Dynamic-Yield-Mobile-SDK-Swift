//
//  AssistantModel.swift
//  DyLibrary
//
//  Created by Avi Gelkop on 16/09/2025.
//

import Foundation

/// Model class for Assistant requests
///
public class AssistantModel: EndpointModelProtocol {
    var logger: DYLogger

    var endpointModelProvider: EndpointModelProvider
    private let page: Page
    private let branchId: String?
    private let options: AssistantOptions?
    private let pageAttributes: [String: PageAttribute]?
    private let addDeviceDateTime: Bool
    private let text: String
    private let chatId: String?

    public init(
        endpointModelProvider: EndpointModelProvider,
        page: Page,
        branchId: String? = nil,
        options: AssistantOptions? = nil,
        pageAttributes: [String: PageAttribute]? = nil,
        addDeviceDateTime: Bool = true,
        text: String,
        chatId: String? = nil
    ) {
        self.endpointModelProvider = endpointModelProvider
        self.page = page
        self.branchId = branchId
        self.options = options
        self.pageAttributes = pageAttributes
        self.text = text
        self.chatId = chatId
        self.addDeviceDateTime = addDeviceDateTime

        logger = DYLogger(logCategory: logCategory)

        logger.log(LoggingUtils.initLogMessage(type(of: self)))
    }

    var httpMethod = HttpMethod.post

    var logCategory = "Assistant Endpoint"

    var urlMethod = EndpointModelUtils.AssistantUrl

    func encodingFailureMessage() -> String {
        "encode payload object for assistant variation"
    }

    func getNetworkFailureMessage() -> String {
        "failed get Assistant results for text: \(text)"
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

        let selector = SingleNameSelector(name: "Shopping Muse")

        let query = AssistantQuery(text: text, chatId: chatId)

        let context = Context(
            page: page,
            device: device,
            branch: (branchId != nil) ? Branch(
                id: branchId
            ) : nil,
            channel: endpointModelProvider.getExperienceConfig().channel,
            pageAttributes: pageAttributes
        )

        let assistantPayloadData = AssistantEndpointPayload(
            session: endpointModelProvider.getSession(),
            user: endpointModelProvider.getUser(cuid: nil, cuidType: nil),
            query: query,
            selector: selector,
            context: context,
            options: options?.isEmpty() ?? true ? nil : options
        )

        return try endpointModelProvider.encodingPayload(payload: assistantPayloadData)
    }
}

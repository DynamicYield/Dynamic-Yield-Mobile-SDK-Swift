//
//  PageViewModel.swift
//
//
//  Created by Miri Kutainer on 17/09/2024.
//

import Foundation

/// Model class for PageView requests

class PageViewModel: EndpointModelProtocol {
    var logger: DYLogger

    private var page: Page

    var httpMethod = HttpMethod.post
    var urlMethod = EndpointModelUtils.pageViewUrl
    var endpointModelProvider: EndpointModelProvider
    var logCategory = "Pageview Endpoint"

    private let addDeviceDateTime: Bool

    init(endpointModelProvider: EndpointModelProvider, page: Page, addDeviceDateTime: Bool = true) {
        self.endpointModelProvider = endpointModelProvider
        self.page = page
        self.addDeviceDateTime = addDeviceDateTime

        logger = DYLogger(logCategory: logCategory)
        logger.log(LoggingUtils.initLogMessage(type(of: self)))
    }

    func encodingFailureMessage() -> String {
        "failed to send pageview"
    }

    func getNetworkFailureMessage() -> String {
        "failed encode payload object for pageview"
    }

    func getPayload() throws -> Data? {
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
            channel: endpointModelProvider.getExperienceConfig().channel)

        let choosePayloadData = ChoosePayload(
            session: endpointModelProvider.getSession(),
            user: endpointModelProvider.getUser(cuid: nil, cuidType: nil),
            context: context)

        return try endpointModelProvider.encodingPayload(payload: choosePayloadData)
    }
}

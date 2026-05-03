//
//  EngagementModel.swift
//
//
//  Created by Miri Kutainer on 17/09/2024.
//

import Foundation

/// Model class for Experience requests

class EngagementModel: EndpointModelProtocol {

    private var engagements: [BaseEngagement]
    private var branchId: String?
    private var dayPart: DayPart?

    var endpointModelProvider: EndpointModelProvider
    var logger: DYLogger
    var httpMethod = HttpMethod.post
    var urlMethod = EndpointModelUtils.engagementUrl
    var ignoreWhenMissingActiveConsentAccepted = true
    var logCategory = "Engagement Endpoint"

    init(endpointModelProvider: EndpointModelProvider, engagements: [BaseEngagement], branchId: String? = nil, dayPart: DayPart? = nil) {
        self.endpointModelProvider = endpointModelProvider
        self.engagements = engagements
        self.branchId = branchId
        self.dayPart = dayPart

        logger = DYLogger(logCategory: logCategory)
        logger.log(LoggingUtils.initLogMessage(type(of: self)))
    }

    func encodingFailureMessage() -> String {
        "failed to send engagement"
    }

    func getNetworkFailureMessage() -> String {
        "failed encode payload object for engagement"
    }

    func getPayload() throws -> Data? {
        let device = Device(ip: endpointModelProvider.getExperienceConfig().ip, addDateTime: false)

        let engagementsPayload = EngagementsPayload(user: endpointModelProvider.getUser(cuid: nil, cuidType: nil), session: endpointModelProvider.getSession(), context: Context(
            device: device,
            branch: dayPart != nil && branchId != nil ? Branch(
                id: branchId,
                dayPart: dayPart
            ) : nil, channel: endpointModelProvider.getExperienceConfig().channel), engagements: engagements)

        return try endpointModelProvider.encodingPayload(payload: engagementsPayload)
    }
}

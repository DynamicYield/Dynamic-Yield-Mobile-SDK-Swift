//
//  EventModel.swift
//
//
//  Created by Miri Kutainer on 17/09/2024.
//

import Foundation

/// Model class for Event requests

class EventModel: EndpointModelProtocol {
    var logger: DYLogger

    private let events: [DYEvent]
    private let branchId: String?
    private let dayPart: DayPart?
    private let orderFulfillment: OrderFulfillment?

    var httpMethod = HttpMethod.post
    var urlMethod = EndpointModelUtils.eventUrl
    var endpointModelProvider: EndpointModelProvider
    var logCategory = "Event Endpoint"

    init(endpointModelProvider: EndpointModelProvider, events: [DYEvent], branchId: String? = nil, dayPart: DayPart? = nil, orderFulfillment: OrderFulfillment? = nil) {
        self.endpointModelProvider = endpointModelProvider
        self.events = events
        self.branchId = branchId
        self.dayPart = dayPart
        self.orderFulfillment = orderFulfillment

        logger = DYLogger(logCategory: logCategory)
        logger.log(LoggingUtils.initLogMessage(type(of: self)))
    }

    func encodingFailureMessage() -> String {
        "failed to send events"
    }

    func getNetworkFailureMessage() -> String {
        "failed encode payload object for events"
    }

    func getPayload() throws -> Data? {

        let device = Device(
            ip: endpointModelProvider.getExperienceConfig().ip,
            addDateTime: false
        )
        let branch = (branchId != nil || dayPart != nil || orderFulfillment != nil) ?
            Branch(id: branchId, dayPart: dayPart, orderFulfillment: orderFulfillment) : nil
        let eventsPayload =
        EventsPayload(
            session: endpointModelProvider.getSession(),
            user: endpointModelProvider.getUser(cuid: nil, cuidType: nil),
            context: Context(
                device: device,
                branch: branch,
                channel: endpointModelProvider.getExperienceConfig().channel
            ),
            events: events
        )

        return try endpointModelProvider.encodingPayload(payload: eventsPayload)
    }
}

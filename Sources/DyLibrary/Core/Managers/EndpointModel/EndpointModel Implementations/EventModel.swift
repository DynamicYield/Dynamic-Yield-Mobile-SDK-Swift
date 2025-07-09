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

    private var events: [DYEvent]

    var httpMethod = HttpMethod.post
    var urlMethod = EndpointModelUtils.eventUrl
    var endpointModelProvider: EndpointModelProvider
    var logCategory = "Event Endpoint"

    init(endpointModelProvider: EndpointModelProvider, events: [DYEvent]) {
        self.endpointModelProvider = endpointModelProvider
        self.events = events

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
        let eventsPayload =
        EventsPayload(
            session: endpointModelProvider.getSession(),
            user: endpointModelProvider.getUser(cuid: nil, cuidType: nil),
            context: Context(
                device: device,
                channel: endpointModelProvider.getExperienceConfig().channel
            ),
            events: events
        )

        return try endpointModelProvider.encodingPayload(payload: eventsPayload)
    }
}

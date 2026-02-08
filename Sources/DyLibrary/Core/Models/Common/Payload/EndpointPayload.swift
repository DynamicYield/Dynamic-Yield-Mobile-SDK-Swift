//
//  EndpointPayload.swift
//
//
//  Created by Miri Kutainer on 16/09/2024.
//

import Foundation

public protocol EndpointPayload: Encodable {

}

class EngagementsPayload: EndpointPayload {
    let user: User
    let session: Session
    let context: Context?
    let engagements: [AnyBaseEngagement]

    init(user: User, session: Session, context: Context?, engagements: [BaseEngagement]) {
        self.user = user
        self.session = session
        self.context = context
        self.engagements = engagements.map { AnyBaseEngagement(baseEngagement: $0) }
    }

    enum CodingKeys: String, CodingKey {
        case user
        case session
        case context
        case engagements
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(user, forKey: .user)
        try container.encode(session, forKey: .session)
        try container.encode(context, forKey: .context)
        try container.encode(engagements, forKey: .engagements)
    }
}

class ChoosePayload: EndpointPayload {
    let session: Session
    let user: User
    let selector: Selector?
    let context: Context?
    let options: Options?

    init(session: Session, user: User, selector: Selector? = nil, context: Context? = nil, options: Options? = nil) {
        self.session = session
        self.user = user
        self.selector = selector
        self.context = context
        self.options = options
    }

    // MARK: Encodable
    func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(user, forKey: .user)
        try container.encode(session, forKey: .session)
        if let selector = selector {
            try container.encode(selector, forKey: .selector)
        }
        if let context = context {
            try container.encode(context, forKey: .context)
        }
        if let options = options {
            try container.encode(options, forKey: .options)
        }
    }
    // MARK: CodingKeys
    enum CodingKeys: String, CodingKey {
        case session
        case user
        case selector
        case context
        case options
    }
}

class EventsPayload: EndpointPayload {
    let session: Session
    let user: User
    let context: Context?
    let events: [DYEvent]

    // MARK: Init
    init(session: Session, user: User, context: Context?, events: [DYEvent]) {
        self.session = session
        self.user = user
        self.context = context
        self.events = events
    }

    // MARK: Encodable
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(session, forKey: .session)
        try container.encode(user, forKey: .user)
        try container.encode(context, forKey: .context)
        try container.encode(events, forKey: .events)
    }

    // MARK: CodingKeys
    enum CodingKeys: String, CodingKey {
        case session
        case user
        case context
        case events
    }
}

class SearchPayload: EndpointPayload {
    let session: Session
    let user: User
    let selector: SearchSelector
    let context: Context?
    let query: SearchQuery?
    let options: SearchOptions?

    // MARK: Init
    init(session: Session, user: User, selector: SearchSelector, context: Context? = nil, query: SearchQuery? = nil, options: SearchOptions? = nil) {
        self.session = session
        self.user = user
        self.selector = selector
        self.context = context
        self.query = query
        self.options = options

    }

    // MARK: Encodable
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(session, forKey: .session)
        try container.encode(user, forKey: .user)
        try container.encode(selector, forKey: .selector)
        if let context = context {
            try container.encode(context, forKey: .context)
        }
        if let query = query {
            try container.encode(query, forKey: .query)
        }
        if let options = options {
            try container.encode(options, forKey: .options)
        }
    }

    // MARK: CodingKeys
    enum CodingKeys: String, CodingKey {
        case session
        case user
        case selector
        case context
        case query
        case options
    }
}

class AssistantEndpointPayload: EndpointPayload {
    let session: Session
    let user: User
    let query: AssistantQuery
    let selector: SingleNameSelector
    let context: Context?
    let options: AssistantOptions?

    init(session: Session, user: User, query: AssistantQuery, selector: SingleNameSelector, context: Context? = nil, options: AssistantOptions? = nil) {
        self.session = session
        self.user = user
        self.query = query
        self.selector = selector
        self.context = context
        self.options = options
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(user, forKey: .user)
        try container.encode(query, forKey: .query)
        try container.encode(session, forKey: .session)
        try container.encode(selector, forKey: .selector)
        try container.encodeIfPresent(context, forKey: .context)
        try container.encodeIfPresent(options, forKey: .options)
    }

    enum CodingKeys: String, CodingKey {
        case session, user, query, selector, context, options
    }
}

//
//  DYEngagement.swift
//  DYLibrary
//
//  Created by Miri Kutainer on 23/08/2023.
//

import Foundation

public protocol BaseEngagement: Encodable { }

public struct ClickEngagement: BaseEngagement, Encodable {
    public var type: EngagementType
    public var decisionId: String?
    public var variations: [Int]?

    public init(decisionId: String, variations: [Int]? = nil) {
        self.type = EngagementType.click
        self.decisionId = decisionId
        self.variations = variations
    }
}

public struct ImpressionEngagement: BaseEngagement, Encodable {
    public var type: EngagementType
    public var decisionId: String?
    public var variations: [Int]?

    public init(decisionId: String, variations: [Int]? = nil) {
        self.type = EngagementType.imp
        self.decisionId = decisionId
        self.variations = variations
    }
}

public struct SlotClickEngagement: BaseEngagement, Encodable {
    public var type: EngagementType
    public var variations: [Int]?
    public var slotId: String

    public init(variations: [Int]? = nil, slotId: String) {
        self.type = EngagementType.slotClick
        self.variations = variations
        self.slotId = slotId
    }
}

public struct SlotImpressionEngagement: BaseEngagement, Encodable {
    public var type: EngagementType
    public var variations: [Int]?
    public var slotIds: [String]

    public init(variations: [Int]? = nil, slotsIds: [String]) {
        self.type = EngagementType.slotImp
        self.variations = variations
        self.slotIds = slotsIds
    }
}

public struct EngagementPN: BaseEngagement, Encodable {
    public var type: EngagementPNType
    public var trackingData: TrackingData

    public init(trackingData: TrackingData) {
        self.type = EngagementPNType.pnClick
        self.trackingData = trackingData
    }
}

public struct TrackingData: Encodable {
    public var rri: String?
    public var sectionID: String?
    public var reqTs: String?
    public var userID: String?
    public var version: String?
    public var events: [TrackingDataEvent]?

    public init(rri: String? = nil, sectionID: String? = nil, reqTs: String? = nil, userID: String? = nil, version: String? = nil, events: [TrackingDataEvent]? = nil) {
        self.rri = rri
        self.sectionID = sectionID
        self.reqTs = reqTs
        self.userID = userID
        self.version = version
        self.events = events
    }

}

public struct TrackingDataEvent: Encodable {
    public var ver: String?
    public var expVisitId: String?
    public var smech: String?
    public var vars: [Int]?
    public var exp: String?
    public var mech: String?

    public init(ver: String? = nil, expVisitId: String? = nil, smech: String? = nil, vars: [Int]? = nil, exp: String? = nil, mech: String? = nil) {
        self.ver = ver
        self.expVisitId = expVisitId
        self.smech = smech
        self.vars = vars
        self.exp = exp
        self.mech = mech
    }
}

public struct AnyBaseEngagement: Encodable {
    let baseEngagement: BaseEngagement?

    public func encode(to encoder: Encoder) throws {
        try baseEngagement?.encode(to: encoder)
    }
}

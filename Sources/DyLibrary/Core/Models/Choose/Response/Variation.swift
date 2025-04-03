//
//  Variation.swift
//  DYLibrary
//
//  Created by Miri Kutainer on 23/08/2023.
//

import Foundation

public class Variation: Decodable, CustomStringConvertible {
    public let id: Int
    public let payload: Payload
    public let analyticsMetadata: AnalyticsMetadata?
    var decisionId: String = ""

    private enum CodingKeys: String, CodingKey {
        case id
        case payload
        case analyticsMetadata
    }

    private enum PayloadCodingKeys: String, CodingKey {
        case type
    }

    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        // Decode the id first
        self.id = try container.decode(Int.self, forKey: .id)
        self.analyticsMetadata = try container.decodeIfPresent(AnalyticsMetadata.self, forKey: .analyticsMetadata)

        // Decode the payload type based on the DecisionType field
        let payloadContainer = try container.nestedContainer(keyedBy: PayloadCodingKeys.self, forKey: .payload)
        let type = try payloadContainer.decode(DecisionType.self, forKey: .type)

        switch type {
        case .customJSON:
            self.payload = try container.decode(CustomJsonPayload.self, forKey: .payload)
        case .recs:
            self.payload = try container.decode(RecsPayload.self, forKey: .payload)
        case .storeRecs:
            self.payload = try container.decode(StoreRecsPayload.self, forKey: .payload)
        }
    }

    public var description: String {
        return """
        id: \(id),
        payload: \(payload),
        analyticsMetadata: \(analyticsMetadata.map { "\($0)" } ?? "nil"),
        decisionId: \(decisionId)
        """
    }
}

public class CustomVariation: Variation {

}

public class RecsVariation: Variation {

}

public class StoreRecsVariation: Variation {

}

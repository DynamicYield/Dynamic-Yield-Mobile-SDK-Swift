//
//  DecisionType.swift
//  DYLibrary
//
//  Created by Miri Kutainer on 05/06/2023.
//

import Foundation

public enum DecisionType: String, Codable {
    case customJSON = "CUSTOM_JSON"
    case recs = "RECS"
    case storeRecs = "STORE_RECS"
    case sorting = "SORT"

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)

        switch rawValue {
        case "CUSTOM_JSON":
            self = .customJSON
        case "RECS", "RECS_DECISION":
            self = .recs
        case "STORE_RECS":
            self = .storeRecs
        case "SORT":
            self = .sorting
        default:
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Unknown DecisionType: \(rawValue)")
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.rawValue)
    }

}

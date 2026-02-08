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
    case qsrProductRecs = "QSR_PRODUCT_RECS"
    case sorting = "SORT"
    case search = "SEARCH"
    case assistant = "SHOPPING_MUSE"

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)

        switch rawValue {
        case "CUSTOM_JSON":
            self = .customJSON
        case "RECS", "RECS_DECISION":
            self = .recs
        case "QSR_PRODUCT_RECS":
            self = .qsrProductRecs
        case "SORT":
            self = .sorting
        case "SEARCH":
            self = .search
        case "SHOPPING_MUSE":
            self = .assistant
        default:
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Unknown DecisionType: \(rawValue)")
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.rawValue)
    }

}

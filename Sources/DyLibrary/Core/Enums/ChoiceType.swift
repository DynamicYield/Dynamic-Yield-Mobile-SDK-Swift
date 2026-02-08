//
//  ChoiceType.swift
//  DYLibrary
//
//  Created by Miri Kutainer on 25/07/2023.
//

import Foundation

public enum ChoiceType: String, Decodable {
    case decision = "DECISION"
    case recsDecision = "RECS_DECISION"
    case noDecision = "NO_DECISION"
    case qsrProductRecsDecision = "QSR_PRODUCT_RECS_DECISION"
    case sortingDecision = "SORTING_DECISION"
    case semanticSearchDecision = "SEMANTIC_SEARCH_DECISION"
    case visualSearchDecision = "VISUAL_SEARCH_DECISION"
    case assistantDecision = "SHOPPING_MUSE_DECISION"

    // Custom initializer for decoding
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)

        // Attempt to initialize with the raw value
        guard let choiceType = ChoiceType(rawValue: rawValue) else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid ChoiceType value: \(rawValue)")
        }

        self = choiceType
    }
}

//
//  Choice.swift
//  DYLibrary
//
//  Created by Miri Kutainer on 23/08/2023.
//

import Foundation

public class Choice: Decodable, CustomStringConvertible {

    public let id: Int
    public let name: String
    public let type: ChoiceType
    public private(set) var variations: [Variation]
    public let groups: [String]
    public let decisionId: String

    private enum CodingKeys: String, CodingKey {
        case id, name, type, variations, groups, decisionId
    }

    public init(id: Int, name: String, type: ChoiceType, variations: [Variation], groups: [String], decisionId: String) {
        self.id = id
        self.name = name
        self.type = type
        self.variations = variations
        self.groups = groups
        self.decisionId = decisionId
    }

    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.type = try container.decode(ChoiceType.self, forKey: .type)
        self.decisionId = try container.decode(String.self, forKey: .decisionId)
        self.groups = try container.decode([String].self, forKey: .groups)

        // Decode variations and inject the `ChoiceType` if available
        self.variations = []

        guard var variationsContainer = try? container.nestedUnkeyedContainer(forKey: .variations) else {
            return
        }

        while !variationsContainer.isAtEnd {
            var variation: Variation?
            switch self.type {
            case .decision, .noDecision:
                variation = try variationsContainer.decode(CustomVariation.self)
            case .recsDecision:
                variation = try variationsContainer.decode(RecsVariation.self)
                if let storeRecsPayload = variation?.payload as? RecsPayload {
                    storeRecsPayload.data.slots.forEach { slot in
                        slot.variationId = self.id
                    }
                }
            case .storeRecsDecision:
                variation = try variationsContainer.decode(StoreRecsVariation.self)
                if let storeRecsPayload = variation?.payload as? StoreRecsPayload {
                    storeRecsPayload.data.slots.forEach { slot in
                        slot.variationId = self.id
                    }
                }
            case .sortingDecision:
                variation = try variationsContainer.decode(SortingVariation.self)
                if let sortingPayload = variation?.payload as? SortingPayload {
                    sortingPayload.data.slots.forEach { slot in
                        slot.variationId = self.id
                    }
                }
            }

            if let variation = variation {
                variation.decisionId = self.decisionId
                self.variations.append(variation)
            }

        }
    }

    public var description: String {
        return """
        id: \(id),
        name: \(name),
        type: \(type),
        variations: \(variations),
        groups: \(groups),
        decisionId: \(decisionId)
        """
    }
}

//
//  ChoiceResponse.swift
//  DYLibrary
//
//  Created by Miri Kutainer on 23/08/2023.
//

import Foundation

protocol Response {}

struct EmptyResponse: Response {}

struct ChooseResponse: Response, Decodable {
    public let choices: [any Choice]
    public let cookies: [Cookie]

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        var anyChoices = try container.decode([AnyChoice].self, forKey: .choices)
        for i in anyChoices.indices {
            anyChoices[i].updateVariationsAndSlots()
        }
        self.choices = anyChoices.map { $0.choice }
        self.cookies = try container.decode([Cookie].self, forKey: .cookies)
    }

    private enum CodingKeys: String, CodingKey {
        case choices
        case cookies
    }
}

struct VisualSearchResponse: Response, Decodable {

    public let choices: [VisualSearchChoice]
    public let cookies: [Cookie]

    private enum CodingKeys: String, CodingKey {
        case choices
        case cookies
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.choices =  try container.decode([VisualSearchChoice].self, forKey: .choices)
        self.cookies = try container.decode([Cookie].self, forKey: .cookies)
        for choice in choices {
            for variation in choice.variations {
                variation.decisionId = choice.decisionId
                variation.payload.data.slots?.forEach { $0.variationId = variation.id }
            }
        }
    }
}

struct SemanticSearchResponse: Response, Decodable {
    public let choices: [SemanticSearchChoice]
    public let cookies: [Cookie]

    private enum CodingKeys: String, CodingKey {
        case choices
        case cookies
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.choices =  try container.decode([SemanticSearchChoice].self, forKey: .choices)
        self.cookies = try container.decode([Cookie].self, forKey: .cookies)
        for choice in choices {
            for variation in choice.variations {
                variation.decisionId = choice.decisionId
                variation.payload.data.slots?.forEach { $0.variationId = variation.id }
            }
        }
    }
}

struct AssistantResponse: Response, Decodable {
    public let choices: [AssistantChoice]
    public let cookies: [Cookie]

    private enum CodingKeys: String, CodingKey {
        case choices
        case cookies
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.choices =  try container.decode([AssistantChoice].self, forKey: .choices)
        self.cookies = try container.decode([Cookie].self, forKey: .cookies)
        for choice in choices {
            for variation in choice.variations {
                variation.decisionId = choice.decisionId
                variation.payload.data.widgets?.forEach {
                    $0.slots.forEach { $0.variationId = variation.id }
                }
            }
        }
    }
}

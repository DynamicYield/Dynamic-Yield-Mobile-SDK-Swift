//
//  Choice.swift
//  DYLibrary
//
//  Created by Miri Kutainer on 23/08/2023.
//

import Foundation

// MARK: - Choice Protocol
public protocol Choice: CustomStringConvertible, Decodable {
    associatedtype VariationType: Variation

    var id: Int { get }
    var name: String { get }
    var type: ChoiceType { get }
    var decisionId: String? { get }
    var variations: [VariationType] { get }
    var groups: [String]? { get }
}

public class RecsChoice: Choice {

    public var id: Int
    public var name: String
    public var type: ChoiceType
    public var decisionId: String?
    public var variations: [RecsVariation]
    public var groups: [String]?

    public var description: String {
        return """
        id: \(id),
        name: \(name),
        type: \(type),
        variations: \(variations),
        groups: \(String(describing: groups)),
        decisionId: \(String(describing: decisionId))
        """
    }

    init(id: Int, name: String, decisionId: String? = nil, variations: [RecsVariation], groups: [String]? = nil) {
        self.id = id
        self.name = name
        self.type = ChoiceType.recsDecision
        self.decisionId = decisionId
        self.variations = variations
        self.groups = groups
    }
}

public class CustomChoice: Choice {

    public var id: Int
    public var name: String
    public var type: ChoiceType
    public var decisionId: String?
    public var variations: [CustomVariation]
    public var groups: [String]?

    public var description: String {
        return """
        id: \(id),
        name: \(name),
        type: \(type),
        variations: \(variations),
        groups: \(String(describing: groups)),
        decisionId: \(String(describing: decisionId))
        """
    }

    init(id: Int, name: String, decisionId: String? = nil, variations: [CustomVariation], groups: [String]? = nil) {
        self.id = id
        self.name = name
        self.type = ChoiceType.decision
        self.decisionId = decisionId
        self.variations = variations
        self.groups = groups
    }
}

public class QsrProductRecsChoice: Choice {

    public var id: Int
    public var name: String
    public var type: ChoiceType
    public var decisionId: String?
    public var variations: [QsrProductRecsVariation]
    public var groups: [String]?

    public var description: String {
        return """
        id: \(id),
        name: \(name),
        type: \(type),
        variations: \(variations),
        groups: \(String(describing: groups)),
        decisionId: \(String(describing: decisionId))
        """
    }

    init(id: Int, name: String, decisionId: String? = nil, variations: [QsrProductRecsVariation], groups: [String]? = nil) {
        self.id = id
        self.name = name
        self.type = ChoiceType.qsrProductRecsDecision
        self.decisionId = decisionId
        self.variations = variations
        self.groups = groups
    }
}

public class SortingChoice: Choice {

    public var id: Int
    public var name: String
    public var type: ChoiceType
    public var decisionId: String?
    public var variations: [SortingVariation]
    public var groups: [String]?

    public var description: String {
        return """
        id: \(id),
        name: \(name),
        type: \(type),
        variations: \(variations),
        groups: \(String(describing: groups)),
        decisionId: \(String(describing: decisionId))
        """
    }

    init(id: Int, name: String, decisionId: String? = nil, variations: [SortingVariation], groups: [String]? = nil) {
        self.id = id
        self.name = name
        self.type = ChoiceType.sortingDecision
        self.decisionId = decisionId
        self.variations = variations
        self.groups = groups
    }
}

public class VisualSearchChoice: Choice {

    public var id: Int
    public var name: String
    public var type: ChoiceType
    public var decisionId: String?
    public var variations: [VisualSearchVariation]
    public var groups: [String]?

    public var description: String {
        return """
        id: \(id),
        name: \(name),
        type: \(type),
        variations: \(variations),
        groups: \(String(describing: groups)),
        decisionId: \(String(describing: decisionId))
        """
    }

    init(id: Int, name: String, decisionId: String? = nil, variations: [VisualSearchVariation], groups: [String]? = nil) {
        self.id = id
        self.name = name
        self.type = ChoiceType.visualSearchDecision
        self.decisionId = decisionId
        self.variations = variations
        self.groups = groups
    }
}

public class SemanticSearchChoice: Choice {

    public var id: Int
    public var name: String
    public var type: ChoiceType
    public var decisionId: String?
    public var variations: [SemanticSearchVariation]
    public var groups: [String]?

    public var description: String {
        return """
        id: \(id),
        name: \(name),
        type: \(type),
        variations: \(variations),
        groups: \(String(describing: groups)),
        decisionId: \(String(describing: decisionId))
        """
    }

    init(id: Int, name: String, decisionId: String? = nil, variations: [SemanticSearchVariation], groups: [String]? = nil) {
        self.id = id
        self.name = name
        self.type = ChoiceType.semanticSearchDecision
        self.decisionId = decisionId
        self.variations = variations
        self.groups = groups
    }
}

public class AssistantChoice: Choice {

    public let id: Int
    public let name: String
    public var type: ChoiceType
    public var decisionId: String?
    public var variations: [AssistantVariation]
    public var groups: [String]?

    private enum CodingKeys: String, CodingKey {
        case id, name, type, variations, decisionId
    }

    public var description: String {
        return """
        id: \(id),
        name: \(name),
        type: \(type),
        variations: \(variations),
        groups: \(String(describing: groups)),
        decisionId: \(String(describing: decisionId))
        """
    }

    init(id: Int, name: String, decisionId: String? = nil, variations: [AssistantVariation], groups: [String]? = nil) {
        self.id = id
        self.name = name
        self.type = ChoiceType.assistantDecision
        self.decisionId = decisionId
        self.variations = variations
        self.groups = groups
    }
}

public enum AnyChoice: Decodable, CustomStringConvertible {
    case recs(RecsChoice)
    case custom(CustomChoice)
    case sorting(SortingChoice)
    case qsrProductRecs(QsrProductRecsChoice)
    case visualSearch(VisualSearchChoice)
    case semanticSearch(SemanticSearchChoice)
    case assistant(AssistantChoice)

    public var choice: any Choice {
        switch self {
        case .recs(let c): return c
        case .custom(let c): return c
        case .qsrProductRecs(let c): return c
        case .sorting(let c): return c
        case .visualSearch(let c): return c
        case .semanticSearch(let c): return c
        case .assistant(let c): return c
        }
    }

    private enum CodingKeys: String, CodingKey {
        case type
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(ChoiceType.self, forKey: .type)
        switch type {
        case .recsDecision:
            self = .recs(try RecsChoice(from: decoder))
        case .decision, .noDecision:
            self = .custom(try CustomChoice(from: decoder))
        case .sortingDecision:
            self = .sorting(try SortingChoice(from: decoder))
        case .qsrProductRecsDecision:
            self = .qsrProductRecs(try QsrProductRecsChoice(from: decoder))
        case .visualSearchDecision:
            self = .visualSearch(try VisualSearchChoice(from: decoder))
        case .semanticSearchDecision:
            self = .semanticSearch(try SemanticSearchChoice(from: decoder))
        case .assistantDecision:
            self = .assistant(try AssistantChoice(from: decoder))
        }
    }

    public var description: String {
        switch self {
        case .recs(let choice): return choice.description
        case .custom(let choice): return choice.description
        case .sorting(let choice): return choice.description
        case .qsrProductRecs(let choice): return choice.description
        case .visualSearch(let choice): return choice.description
        case .semanticSearch(let choice): return choice.description
        case .assistant(let choice): return choice.description
        }
    }

    public mutating func updateVariationsAndSlots() {

        switch self {
        case .recs(let choice):
            for variation in choice.variations {
                variation.decisionId = choice.decisionId
                variation.payload.data.slots.forEach { $0.variationId = variation.id }
            }

        case .qsrProductRecs(let choice):
            for variation in choice.variations {
                variation.decisionId = choice.decisionId
                variation.payload.data.slots.forEach { $0.variationId = variation.id }

            }
        case .sorting(let choice):
            for variation in choice.variations {
                variation.decisionId = choice.decisionId
                variation.payload.data.slots.forEach { $0.variationId = variation.id }

            }
        case .visualSearch(let choice):
            for variation in choice.variations {
                variation.decisionId = choice.decisionId
                variation.payload.data.slots?.forEach { $0.variationId = variation.id }

            }
        case .semanticSearch(let choice):
            for variation in choice.variations {
                variation.decisionId = choice.decisionId
                variation.payload.data.slots?.forEach { $0.variationId = variation.id }

            }
        case .custom(let choice):
            for variation in choice.variations {
                variation.decisionId = choice.decisionId
            }
        case .assistant(let choice):
            for variation in choice.variations {
                variation.decisionId = choice.decisionId
                variation.payload.data.widgets?.forEach { $0.slots.forEach {$0.variationId = variation.id}}
            }
        }
    }
}

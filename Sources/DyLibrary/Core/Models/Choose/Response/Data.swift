//
//  RecsData.swift
//  DyLibrary
//
//  Created by Avi Gelkop on 15/10/2025.
//

import Foundation

public class RecsData: Decodable {
    public let custom: String
    public let slots: [RecsSlot]

    private enum CodingKeys: CodingKey {
        case custom
        case slots
    }

    init(custom: String, slots: [RecsSlot]) {
        self.custom = custom
        self.slots = slots
    }

    public required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.custom = try container.decodeCustomJSONAsString(forKey: .custom) ?? ""
        self.slots = try container.decodeIfPresent([RecsSlot].self, forKey: .slots) ?? []

    }

}

public class QsrProductRecsData: Decodable {
    public let custom: String
    public let slots: [QsrProductRecsSlot]

    private enum CodingKeys: CodingKey {
        case custom
        case slots
    }

    init(custom: String, slots: [QsrProductRecsSlot]) {
        self.custom = custom
        self.slots = slots
    }

    public required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let jsonDict = try? container.decodeIfPresent([String: AnyDecodable].self, forKey: .custom) {
            let jsonData = try JSONSerialization.data(withJSONObject: jsonDict.mapValues { $0.value })
            self.custom = String(data: jsonData, encoding: .utf8) ?? "{}"
        } else if let jsonArray = try? container.decode([AnyDecodable].self, forKey: .custom) {
            let jsonData = try JSONSerialization.data(withJSONObject: jsonArray.map { $0.value })
            self.custom = String(data: jsonData, encoding: .utf8) ?? "[]"
        } else {
            self.custom = "" // Default empty string
        }
        self.slots = try container.decodeIfPresent([QsrProductRecsSlot].self, forKey: .slots) ?? []

    }

}

public class SortingData: Decodable {
    public let slots: [SortingRecsSlot]

    private enum CodingKeys: CodingKey {
        case slots
    }

    public required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.slots = try container.decodeIfPresent([SortingRecsSlot].self, forKey: .slots) ?? []
    }

    init(slots: [SortingRecsSlot]) {
        self.slots = slots
    }
}

public class VisualSearchData: Decodable {
    public let facets: [Facet]?
    public let totalNumResults: Int?
    public let slots: [RecsSlot]?
    public let custom: String?

    private enum CodingKeys: CodingKey {
        case facets
        case totalNumResults
        case slots
        case custom
    }

    public required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.slots = try container.decodeIfPresent([RecsSlot].self, forKey: .slots)
        self.totalNumResults = try container.decodeIfPresent(Int.self, forKey: .totalNumResults)
        let anyFacets = try container.decodeIfPresent([AnyFacet].self, forKey: .facets)
        self.facets = anyFacets?.map { $0.facet } ?? nil
        self.custom = try container.decodeCustomJSONAsString(forKey: .custom) ?? nil
    }

    init(facets: [Facet]?, totalNumResults: Int?, slots: [RecsSlot]?, custom: String?) {
        self.facets = facets
        self.totalNumResults = totalNumResults
        self.slots = slots
        self.custom = custom
    }
}

public class SemanticSearchData: Decodable {
    public let facets: [Facet]?
    public let totalNumResults: Int?
    public let spellCheckedQuery: String?
    public let slots: [RecsSlot]?
    public let custom: String?

    private enum CodingKeys: CodingKey {
        case facets
        case totalNumResults
        case slots
        case spellCheckedQuery
        case custom
    }

    public required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.slots = try container.decodeIfPresent([RecsSlot].self, forKey: .slots)
        self.totalNumResults = try container.decodeIfPresent(Int.self, forKey: .totalNumResults)
        self.spellCheckedQuery = try container.decodeIfPresent(String.self, forKey: .spellCheckedQuery)

        let anyFacets = try container.decodeIfPresent([AnyFacet].self, forKey: .facets)
        self.facets = anyFacets?.map { $0.facet } ?? nil

        self.custom = try container.decodeCustomJSONAsString(forKey: .custom) ?? nil
    }

    init(facets: [Facet]?, totalNumResults: Int?, spellCheckedQuery: String?, slots: [RecsSlot]?, custom: String?) {
        self.facets = facets
        self.totalNumResults = totalNumResults
        self.spellCheckedQuery = spellCheckedQuery
        self.slots = slots
        self.custom = custom
    }
}

public class AssistantData: Decodable {
    public let assistant: String?
    public let widgets: [Widget]?
    public let support: Bool?
    public let chatId: String?

    private enum CodingKeys: CodingKey {
        case assistant
        case widgets
        case support
        case chatId
    }

    public required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.assistant = try container.decodeIfPresent(String.self, forKey: .assistant)
        self.widgets = try container.decodeIfPresent([Widget].self, forKey: .widgets)
        self.support = try container.decodeIfPresent(Bool.self, forKey: .support)
        self.chatId = try container.decodeIfPresent(String.self, forKey: .chatId)
    }

    init (assistant: String?, widgets: [Widget]?, support: Bool?, chatId: String?) {
        self.assistant = assistant
        self.widgets = widgets
        self.support = support
        self.chatId = chatId
    }
}

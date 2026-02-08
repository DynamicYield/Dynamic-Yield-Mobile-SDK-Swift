//
//  Payload.swift
//
//
//  Created by Miri Kutainer on 16/09/2024.
//

import Foundation

public protocol Payload: Decodable {
    var type: DecisionType { get }
}

public class CustomJsonPayload: Payload {
    public let type: DecisionType
    public var data: String

    public init(type: DecisionType, data: String) {
        self.type = type
        self.data = data
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decodeCustomJSONAsString(forKey: .data) ?? ""
        self.type = try container.decode(DecisionType.self, forKey: .type)
    }

    enum CodingKeys: String, CodingKey {
        case data
        case type
    }
}

public class RecsPayload: Payload {
    public let type: DecisionType
    public var data: RecsData

    public init(type: DecisionType, data: RecsData) {
        self.type = type
        self.data = data
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode(RecsData.self, forKey: .data)
        self.type = try container.decode(DecisionType.self, forKey: .type)
    }

    enum CodingKeys: String, CodingKey {
        case data
        case type
    }
}

public class QsrProductRecsPayload: Payload {
    public let type: DecisionType
    public let data: QsrProductRecsData

    public init(type: DecisionType, data: QsrProductRecsData) {
        self.type = type
        self.data = data
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode(QsrProductRecsData.self, forKey: .data)
        self.type = try container.decode(DecisionType.self, forKey: .type)
    }

    enum CodingKeys: String, CodingKey {
        case data
        case type
    }
}

public class SortingPayload: Payload {
    public let type: DecisionType
    public let data: SortingData

    public init(type: DecisionType, data: SortingData) {
        self.type = type
        self.data = data
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode(SortingData.self, forKey: .data)
        self.type = try container.decode(DecisionType.self, forKey: .type)
    }

    enum CodingKeys: String, CodingKey {
        case data
        case type
    }
}

public class VisualSearchPayload: Payload {
    public let type: DecisionType
    public let data: VisualSearchData

    public init(type: DecisionType, data: VisualSearchData) {
        self.type = type
        self.data = data
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode(VisualSearchData.self, forKey: .data)
        self.type = try container.decode(DecisionType.self, forKey: .type)
    }

    enum CodingKeys: String, CodingKey {
        case data
        case type
    }
}

public class SemanticSearchPayload: Payload {
    public let type: DecisionType
    public let data: SemanticSearchData

    public init(type: DecisionType, data: SemanticSearchData) {
        self.type = type
        self.data = data
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode(SemanticSearchData.self, forKey: .data)
        self.type = try container.decode(DecisionType.self, forKey: .type)
    }

    enum CodingKeys: String, CodingKey {
        case data
        case type
    }
}

public class AssistantPayload: Payload {
    public var type: DecisionType
    public let data: AssistantData

    public init(type: DecisionType, data: AssistantData) {
        self.type = type
        self.data = data
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode(AssistantData.self, forKey: .data)
        self.type = try container.decode(DecisionType.self, forKey: .type)
    }

    enum CodingKeys: String, CodingKey {
        case data
        case type
    }
}

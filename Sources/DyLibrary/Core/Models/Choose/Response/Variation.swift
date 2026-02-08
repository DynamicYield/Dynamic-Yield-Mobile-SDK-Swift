//
//  Variation.swift
//  DYLibrary
//
//  Created by Miri Kutainer on 23/08/2023.
//

import Foundation

public protocol Variation: Decodable, CustomStringConvertible {
    associatedtype PayloadType: Payload
    var id: Int { get }
    var payload: PayloadType { get }
    var analyticsMetadata: AnalyticsMetadata? { get }
    var decisionId: String? { get set }
}

// MARK: - CustomVariation
public class CustomVariation: Variation {
    public let id: Int
    public let payload: CustomJsonPayload
    public let analyticsMetadata: AnalyticsMetadata?
    public var decisionId: String?
    public var rolloutFlag: Bool?

    private enum CodingKeys: String, CodingKey {
        case id
        case payload
        case analyticsMetadata
        case rolloutFlag
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.analyticsMetadata = try container.decodeIfPresent(AnalyticsMetadata.self, forKey: .analyticsMetadata)
        self.payload = try container.decode(CustomJsonPayload.self, forKey: .payload)
        self.rolloutFlag = try container.decodeIfPresent(Bool.self, forKey: .rolloutFlag)
    }

    init(id: Int, payload: CustomJsonPayload, analyticsMetadata: AnalyticsMetadata?  = nil, decisionId: String? = nil, rolloutFlag: Bool? = nil) {
        self.id = id
        self.payload = payload
        self.analyticsMetadata = analyticsMetadata
        self.decisionId = decisionId
        self.rolloutFlag = rolloutFlag
    }

    public var description: String {
        return "id: \(id), payload: \(payload), analyticsMetadata: \(analyticsMetadata.map { "\($0)" } ?? "nil"), decisionId: \(String(describing: decisionId)), rolloutFlag: \(String(describing: rolloutFlag))"
    }
}

// MARK: - RecsVariation
public class RecsVariation: Variation {
    public let id: Int
    public let payload: RecsPayload
    public let analyticsMetadata: AnalyticsMetadata?
    public var decisionId: String?

    private enum CodingKeys: String, CodingKey {
        case id
        case payload
        case analyticsMetadata
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.analyticsMetadata = try container.decodeIfPresent(AnalyticsMetadata.self, forKey: .analyticsMetadata)
        self.payload = try container.decode(RecsPayload.self, forKey: .payload)
    }

    init(id: Int, payload: RecsPayload, analyticsMetadata: AnalyticsMetadata?  = nil, decisionId: String? = nil) {
        self.id = id
        self.payload = payload
        self.analyticsMetadata = analyticsMetadata
        self.decisionId = decisionId
    }

    public var description: String {
        return "id: \(id), payload: \(payload), analyticsMetadata: \(analyticsMetadata.map { "\($0)" } ?? "nil"), decisionId: \(String(describing: decisionId))"
    }
}

// MARK: - QsrProductRecsVariation
public class QsrProductRecsVariation: Variation {
    public let id: Int
    public let payload: QsrProductRecsPayload
    public let analyticsMetadata: AnalyticsMetadata?
    public var decisionId: String?
    public let name: String?

    private enum CodingKeys: String, CodingKey {
        case id
        case payload
        case analyticsMetadata
        case title
        case name
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.analyticsMetadata = try container.decodeIfPresent(AnalyticsMetadata.self, forKey: .analyticsMetadata)
        self.payload = try container.decode(QsrProductRecsPayload.self, forKey: .payload)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
    }

    init(id: Int, payload: QsrProductRecsPayload, analyticsMetadata: AnalyticsMetadata? = nil, decisionId: String? = nil, name: String? = nil) {
        self.id = id
        self.payload = payload
        self.analyticsMetadata = analyticsMetadata
        self.decisionId = decisionId
        self.name = name
    }

    public var description: String {
        return "id: \(id), payload: \(payload), analyticsMetadata: \(analyticsMetadata.map { "\($0)" } ?? "nil"), decisionId: \(String(describing: decisionId)),  name: \(name ?? "nil")"
    }
}

// MARK: - SortingVariation
public class SortingVariation: Variation {
    public let id: Int
    public let payload: SortingPayload
    public let analyticsMetadata: AnalyticsMetadata?
    public var decisionId: String?

    private enum CodingKeys: String, CodingKey {
        case id
        case payload
        case analyticsMetadata
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.analyticsMetadata = try container.decodeIfPresent(AnalyticsMetadata.self, forKey: .analyticsMetadata)
        self.payload = try container.decode(SortingPayload.self, forKey: .payload)
    }

    init(id: Int, payload: SortingPayload, analyticsMetadata: AnalyticsMetadata? = nil, decisionId: String? = nil) {
        self.id = id
        self.payload = payload
        self.analyticsMetadata = analyticsMetadata
        self.decisionId = decisionId
    }

    public var description: String {
        return "id: \(id), payload: \(payload), analyticsMetadata: \(analyticsMetadata.map { "\($0)" } ?? "nil"), decisionId: \(String(describing: decisionId))"
    }
}

// MARK: - VisualSearchVariation
public class VisualSearchVariation: Variation {
    public let id: Int
    public let payload: VisualSearchPayload
    public let analyticsMetadata: AnalyticsMetadata?
    public var decisionId: String?

    private enum CodingKeys: String, CodingKey {
        case id
        case payload
        case analyticsMetadata
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.analyticsMetadata = try container.decodeIfPresent(AnalyticsMetadata.self, forKey: .analyticsMetadata)
        self.payload = try container.decode(VisualSearchPayload.self, forKey: .payload)
    }

    init(id: Int, payload: VisualSearchPayload, analyticsMetadata: AnalyticsMetadata? = nil, decisionId: String? = nil) {
        self.id = id
        self.payload = payload
        self.analyticsMetadata = analyticsMetadata
        self.decisionId = decisionId
    }

    public var description: String {
        return "id: \(id), payload: \(payload), analyticsMetadata: \(analyticsMetadata.map { "\($0)" } ?? "nil"), decisionId: \(String(describing: decisionId))"
    }
}

// MARK: - SemanticSearchVariation
public class SemanticSearchVariation: Variation {
    public let id: Int
    public let payload: SemanticSearchPayload
    public let analyticsMetadata: AnalyticsMetadata?
    public var decisionId: String?

    private enum CodingKeys: String, CodingKey {
        case id
        case payload
        case analyticsMetadata
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.analyticsMetadata = try container.decodeIfPresent(AnalyticsMetadata.self, forKey: .analyticsMetadata)
        self.payload = try container.decode(SemanticSearchPayload.self, forKey: .payload)
    }

    init(id: Int, payload: SemanticSearchPayload, analyticsMetadata: AnalyticsMetadata? = nil, decisionId: String? = nil) {
        self.id = id
        self.payload = payload
        self.analyticsMetadata = analyticsMetadata
        self.decisionId = decisionId
    }

    public var description: String {
        return "id: \(id), payload: \(payload), analyticsMetadata: \(analyticsMetadata.map { "\($0)" } ?? "nil"), decisionId: \(String(describing: decisionId))"
    }
}

public class AssistantVariation: Variation {

    public var id: Int

    public var analyticsMetadata: AnalyticsMetadata?
    public let payload: AssistantPayload
    public var decisionId: String?

    private enum CodingKeys: String, CodingKey {
        case id
        case payload
        case analyticsMetadata
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.analyticsMetadata = try container.decodeIfPresent(AnalyticsMetadata.self, forKey: .analyticsMetadata)
        self.payload = try container.decode(AssistantPayload.self, forKey: .payload)
    }

    init(id: Int, analyticsMetadata: AnalyticsMetadata? = nil, payload: AssistantPayload, decisionId: String? = nil) {
        self.id = id
        self.analyticsMetadata = analyticsMetadata
        self.payload = payload
        self.decisionId = decisionId
    }

    public var description: String {
        return "id: \(id), payload: \(payload), analyticsMetadata: \(analyticsMetadata.map { "\($0)" } ?? "nil"), decisionId: \(String(describing: decisionId))"
    }
}

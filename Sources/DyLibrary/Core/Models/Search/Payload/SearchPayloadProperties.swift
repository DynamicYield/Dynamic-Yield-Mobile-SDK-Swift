//
//  SearchPayloadProperties.swift
//
//
//  Created by Miri Kutainer on 23/08/2023.
//

import Foundation

public struct SearchSelector: Encodable {
    public var name: SearchType
}

public struct Pagination: Codable {
    public var numItems: UInt
    public var offset: UInt

    public init(numItems: UInt, offset: UInt) {
        self.numItems = numItems
        self.offset = offset
    }
}

public struct SearchOptions: Codable {
    public var returnAnalyticsMetadata: Bool?
    public var productData: RecsProductDataOptions?

    public init(returnAnalyticsMetadata: Bool? = nil, productData: RecsProductDataOptions? = nil) {
        self.returnAnalyticsMetadata = returnAnalyticsMetadata
        self.productData = productData
    }
}

public enum SearchQuery: Encodable {
    case semanticQuery(String, [Filter]? = nil, Pagination, SortOptions? = nil)
    case visualQuery(String, [Filter]? = nil, SortOptions? = nil)

    enum SemanticQueryCodingKeys: CodingKey {
        case text
        case filters
        case pagination
        case sortBy
    }

    enum VisualQueryCodingKeys: CodingKey {
        case imageBase64
        case filters
        case sortBy
    }

    public func encode(to encoder: any Encoder) throws {
        switch self {
        case .semanticQuery(let text, let filters, let pagination, let sortBy):
            var container = encoder.container(keyedBy: SemanticQueryCodingKeys.self)
            try container.encodeIfPresent(text, forKey: .text)
            try container.encodeIfPresent(filters, forKey: .filters)
            try container.encodeIfPresent(pagination, forKey: .pagination)
            try container.encodeIfPresent(sortBy, forKey: .sortBy)
        case .visualQuery(let imageBase64, let filters, let sortBy):
            var container = encoder.container(keyedBy: VisualQueryCodingKeys.self)
            try container.encodeIfPresent(imageBase64, forKey: .imageBase64)
            try container.encodeIfPresent(filters, forKey: .filters)
            try container.encodeIfPresent(sortBy, forKey: .sortBy)
        }
    }
}

public enum SortOptions: Encodable {
    case byPopularity(SortOrderType)
    case byField(String, SortOrderType)

    enum CodingKeys: CodingKey {
        case field
        case order
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .byPopularity(let order):
            try container.encodeIfPresent(order, forKey: .order)
            try container.encode("popularity", forKey: .field)
        case .byField(let field, let order):
            try container.encodeIfPresent(order, forKey: .order)
            try container.encodeIfPresent(field, forKey: .field)
        }
    }
}

public enum Filter: Encodable {
    case numericFilter(String, Float? = nil, Float?)
    case stringFilter(String, [String])

    public init(field: String, min: Float? = nil, max: Float? = nil) {
        self = .numericFilter(field, min, max)
    }

    public init(field: String, values: [String]) {
        self = .stringFilter(field, values)
    }

    enum NumericFilterCodingKeys: CodingKey {
        case field
        case min
        case max
    }

    enum StringFilterCodingKeys: CodingKey {
        case field
        case values
    }

    public func encode(to encoder: any Encoder) throws {
        switch self {
        case .numericFilter(let field, let min, let max):
            var container = encoder.container(keyedBy: NumericFilterCodingKeys.self)
            try container.encodeIfPresent(field, forKey: .field)
            try container.encodeIfPresent(min, forKey: .min)
            try container.encodeIfPresent(max, forKey: .max)
        case .stringFilter(let field, let values):
            var container = encoder.container(keyedBy: StringFilterCodingKeys.self)
            try container.encodeIfPresent(field, forKey: .field)
            try container.encodeIfPresent(values, forKey: .values)
        }
    }
}

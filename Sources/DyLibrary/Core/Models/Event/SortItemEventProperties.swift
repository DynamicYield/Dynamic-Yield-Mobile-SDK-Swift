//
//  SortItemEventProperties.swift
//  DYLibrary
//
//  Created by Miri Kutainer on 23/05/2024.
//

import Foundation

public struct SortItemEventProperties: EventProperties {
    public var dyType: String
    var sortBy: String
    var sortOrder: SortOrderType

    public init(sortBy: String, sortOrder: SortOrderType) {
        self.dyType = "sort-items-v1"
        self.sortBy = sortBy
        self.sortOrder = sortOrder
    }

    private enum CodingKeys: String, CodingKey {
        case dyType
        case sortBy
        case sortOrder
    }
}

extension SortItemEventProperties: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(dyType, forKey: .dyType)
        try container.encode(sortBy, forKey: .sortBy)
        try container.encode(String(describing: sortOrder).uppercased(), forKey: .sortOrder)
    }
}

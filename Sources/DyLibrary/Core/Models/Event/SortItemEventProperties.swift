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
}

//
//  FilterItemsEventProperties.swift
//  DYLibrary
//
//  Created by Miri Kutainer on 23/05/2024.
//

import Foundation

public struct FilterItemsEventProperties: EventProperties {
    public var dyType: String
    var filterType: String
    var filterNumericValue: Int?
    var filterStringValue: String?

    public init(filterType: String, filterNumericValue: Int? = nil, filterStringValue: String? = nil) {
        self.dyType = "filter-items-v1"
        self.filterType = filterType
        self.filterNumericValue = filterNumericValue
        self.filterStringValue = filterStringValue

    }
}

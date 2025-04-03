//
//  KeywordSearchEventProperties.swift
//  DYLibrary
//
//  Created by Valeria Pivchik on 22/11/2023.
//

import Foundation

public struct KeywordSearchEventProperties: EventProperties {
    public var dyType: String
    var keywords: String

    public init(keywords: String) {
        self.dyType = "keyword-search-v1"
        self.keywords = keywords
    }
}

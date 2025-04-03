//
//  ChangeAttributesProperties.swift
//  DYLibrary
//
//  Created by Miri Kutainer on 23/05/2024.
//

import Foundation

public struct ChangeAttributesEventProperties: EventProperties {
    public var dyType: String
    var attributeType: String
    var attributeValue: String

    public init(attributeType: String, attributeValue: String) {
        self.dyType = "change-attr-v1"
        self.attributeType = attributeType
        self.attributeValue = attributeValue

    }
}

//
//  PromoCodeEnterEventProperties.swift
//  DYLibrary
//
//  Created by Miri Kutainer on 23/05/2024.
//

import Foundation

public struct PromoCodeEnterEventProperties: EventProperties {
    public var dyType: String
    var code: String

    public init(code: String) {
        self.dyType = "enter-promo-code-v1"
        self.code = code
    }
}

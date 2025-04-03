//
//  AddToWishListEventProperties.swift
//  DYLibrary
//
//  Created by Valeria Pivchik on 22/11/2023.
//

import Foundation

public struct AddToWishListEventProperties: EventProperties {
    public var dyType: String
    var productId: String
    var size: String?

    public init(productId: String, size: String? = nil) {
        self.dyType = "add-to-wishlist-v1"
        self.productId = productId
        self.size = size
    }
}

//
//  CartInnerItem.swift
//
//
//  Created by Miri Kutainer on 22/09/2024.
//

import Foundation

public struct CartInnerItem: Encodable {
    let productId: String?
    let quantity: UInt?
    let itemPrice: Float?

    public init(productId: String?, quantity: UInt?, itemPrice: Float?) {
        self.productId = productId
        self.quantity = quantity
        self.itemPrice = itemPrice
    }
}

//
//  ApplicationEventProperties.swift
//  DYLibrary
//
//  Created by Valeria Pivchik on 22/11/2023.
//

import Foundation

public struct ApplicationEventProperties: EventProperties {

    public var dyType: String
    var value: Float
    var currency: CurrencyType?
    var productId: String
    var quantity: UInt
    var cart: [CartInnerItem]?

    public init(value: Float, currency: CurrencyType? = nil, productId: String, quantity: UInt, cart: [CartInnerItem]? = nil) {
        self.dyType = "add-to-cart-v1"
        self.value = value
        self.currency = currency
        self.productId = productId
        self.quantity = quantity
        self.cart = cart
    }
}

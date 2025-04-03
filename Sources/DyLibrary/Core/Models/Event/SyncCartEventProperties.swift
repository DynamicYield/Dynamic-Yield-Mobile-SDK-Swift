//
//  SyncCartEventProperties.swift
//  DYLibrary
//
//  Created by Valeria Pivchik on 22/11/2023.
//

import Foundation

public struct SyncCartEventProperties: EventProperties {
    public var dyType: String
    var value: Float
    var currency: CurrencyType?
    var cart: [CartInnerItem]

    public init(cart: [CartInnerItem], value: Float, currency: CurrencyType? = nil) {
        self.dyType = "sync-cart-v1"
        self.cart = cart
        self.value = value
        self.currency = currency
    }
}

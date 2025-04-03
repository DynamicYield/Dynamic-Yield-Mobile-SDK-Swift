//
//  PurchaseEventProperties.swift
//  DYLibrary
//
//  Created by Valeria Pivchik on 22/11/2023.
//

import Foundation

public struct PurchaseEventProperties: EventProperties {
    public var dyType: String
    var value: Float
    var currency: CurrencyType?
    var uniqueTransactionId: String?
    var cart: [CartInnerItem]

    public init(value: Float, currency: CurrencyType? = nil, uniqueTransactionId: String? = nil, cart: [CartInnerItem]) {
        self.dyType = "purchase-v1"
        self.value = value
        self.currency = currency
        self.uniqueTransactionId = uniqueTransactionId
        self.cart = cart
    }
}

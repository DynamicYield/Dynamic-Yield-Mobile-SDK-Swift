//
//  ChoicePayloadProperties.swift
//
//
//  Created by Miri Kutainer on 23/08/2023.
//

import Foundation

public struct Selector: Encodable {
    public var names: [String]?
    public var groups: [String]?
    public var preview: Preview?
}

public struct Preview: Codable {
    public var ids: [String]?
}

public struct Options: Codable {

    public var isImplicitPageview: Bool?
    public var returnAnalyticsMetadata: Bool?
    public var isImplicitImpressionMode: Bool?
    public var recsProductData: RecsProductDataOptions?

}

public class RecsProductDataOptions: ProductDataOptions {}

public struct Branch: Codable {
    public var id: String?
    public var dayPart: DayPart?
    public var orderFulfillment: OrderFulfillment?
}

public struct CartItem: Encodable {
    public var productId: String
    public var quantity: UInt
    public var itemPrice: Float?
    public var innerProducts: [CartInnerItem]?

    public init(productId: String, quantity: UInt, itemPrice: Float? = nil, innerProducts: [CartInnerItem]? = nil) {
        self.productId = productId
        self.quantity = quantity
        self.itemPrice = itemPrice
        self.innerProducts = innerProducts
    }
}

public struct ChooseOptions {
    public var isImplicitPageview: Bool?
    public var returnAnalyticsMetadata: Bool?
    public var isImplicitImpressionMode: Bool?

    public init(isImplicitPageview: Bool? = nil, returnAnalyticsMetadata: Bool? = nil, isImplicitImpressionMode: Bool? = nil) {
        self.isImplicitPageview = isImplicitPageview
        self.returnAnalyticsMetadata = returnAnalyticsMetadata
        self.isImplicitImpressionMode = isImplicitImpressionMode
    }
}

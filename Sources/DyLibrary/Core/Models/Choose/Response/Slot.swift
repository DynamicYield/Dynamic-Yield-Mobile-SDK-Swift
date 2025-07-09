//
//  Slot.swift
//
//
//  Created by Miri Kutainer on 16/09/2024.
//

import Foundation

public class Slot: Decodable {
    public let sku: String
    public let slotId: String

    internal var variationId: Int?

    private enum CodingKeys: CodingKey {
        case sku, slotId
    }

    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.sku = try container.decode(String.self, forKey: .sku)
        self.slotId = try container.decode(String.self, forKey: .slotId)
    }
}

public class RecsSlot: Slot {

    public var productData: RecsProductData

    private enum CodingKeys: CodingKey {
        case productData
    }

    public required init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.productData = try container.decode(AnyProductData.self, forKey: .productData).base
        try super.init(from: decoder)
    }
}

public class StoreRecsSlot: Slot {

    public var productData: StoreRecsProductData

    private enum CodingKeys: CodingKey {
        case productData
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.productData = try container.decode(StoreRecsProductData.self, forKey: .productData)
        try super.init(from: decoder)
    }
}

public class SortingRecsSlot: Slot {

    public var productData: SortingRecsProductData

    private enum CodingKeys: CodingKey {
        case productData
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.productData = try container.decode(SortingRecsProductData.self, forKey: .productData)
        try super.init(from: decoder)
    }
}

//
//  ProductData.swift
//  DyLibrary
//
//  Created by Miri Kutainer on 28/10/2024.
//

public protocol ProductData: Decodable { }

public protocol RecsProductData: ProductData { }

public class StoreRecsProductData: ProductData {
    let groupId: String?

    enum CodingKeys: String, CodingKey {
        case groupId = "group_id"
    }

    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        groupId = try container.decodeIfPresent(String.self, forKey: .groupId)
    }
}

public class DefaultRecsProductData: RecsProductData {
    let productType: ProductType?
    let groupId: String?
    let name: String?
    let url: String?
    let price: Float?
    let inStock: Bool?
    let imageUrl: String?
    let categories: [String?]?
    var keywords: [String?]?

    enum CodingKeys: String, CodingKey {
        case productType = "product_type"
        case groupId = "group_id"
        case name
        case url
        case price
        case inStock = "in_stock"
        case imageUrl = "image_url"
        case categories
        case keywords
    }

    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        productType = try container.decodeIfPresent(ProductType.self, forKey: .productType)
        groupId = try container.decodeIfPresent(String.self, forKey: .groupId)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        url = try container.decodeIfPresent(String.self, forKey: .url)
        price = try container.decodeIfPresent(Float.self, forKey: .price)
        inStock = try container.decodeIfPresent(Bool.self, forKey: .inStock)
        imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl)
        categories = try container.decodeIfPresent([String].self, forKey: .categories)
        keywords = try container.decodeIfPresent([String].self, forKey: .keywords)
    }
}

struct AnyProductData: Decodable {
    var base: RecsProductData

    internal static var dynamicType: RecsProductData.Type?

    init(from decoder: Decoder) throws {
        let currentType = Self.dynamicType ?? DefaultRecsProductData.self
        self.base = try currentType.init(from: decoder)
    }
}

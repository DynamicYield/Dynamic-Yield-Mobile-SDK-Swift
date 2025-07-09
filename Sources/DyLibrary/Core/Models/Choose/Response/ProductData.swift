//
//  ProductData.swift
//  DyLibrary
//
//  Created by Miri Kutainer on 28/10/2024.
//
import Foundation

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

public class SortingRecsProductData: ProductData {

}

public class DefaultRecsProductData: RecsProductData {
    public let productType: ProductType?
    public let groupId: String?
    public let name: String?
    public let url: String?
    public let price: Float?
    public let inStock: Bool?
    public let imageUrl: String?
    public let categories: [String?]?
    public var keywords: [String?]?
    public var extra: [String: Any?] = [:]

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

        let rawContainer = try decoder.container(keyedBy: AnyCodingKey.self)
        for key in rawContainer.allKeys {
            // Skip known fields
            if CodingKeys(stringValue: key.stringValue) != nil { continue }

            // Try to decode known types: String, Float
             if let stringValue = try? rawContainer.decode(String.self, forKey: key) {
                extra[key.stringValue] = stringValue
            } else if let floatValue = try? rawContainer.decode(Float.self, forKey: key) {
                extra[key.stringValue] = floatValue
            } else {
                extra[key.stringValue] = nil
            }
        }
    }
}

struct AnyCodingKey: CodingKey {
    var stringValue: String
    var intValue: Int? { return nil }

    init?(stringValue: String) {
        self.stringValue = stringValue
    }

    init?(intValue: Int) {
        return nil // Not supporting integer keys
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

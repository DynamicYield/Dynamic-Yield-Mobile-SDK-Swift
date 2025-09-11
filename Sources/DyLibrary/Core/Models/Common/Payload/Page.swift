//
//  Page.swift
//
//
//  Created by Miri Kutainer on 14/07/2024.
//

import Foundation

public class Page: Encodable {
    let type: PageType
    let location: String
    let data: [String]
    let referrer: String?
    var locale: String?

    private enum CodingKeys: String, CodingKey {
        case type
        case location
        case data
        case referrer
        case locale
    }

     init(type: PageType, location: String, data: [String] = [], referrer: String?, pageLocale: String? = nil) {
        self.type = type
        self.location = location
        self.data = data
        self.referrer = referrer
        self.locale = pageLocale
    }

    public static func homePage(pageLocation: String, referrer: String? = nil, pageLocale: String? = nil) -> Page {
        Page(type: .homepage, location: pageLocation, data: [], referrer: referrer, pageLocale: pageLocale)
    }

    public static func categoryPage(pageLocation: String, categories: [String], pageReferrer: String? = nil, pageLocale: String? = nil) -> Page {
        Page(type: .category, location: pageLocation, data: categories, referrer: pageReferrer, pageLocale: pageLocale)
    }

    public static func productPage(pageLocation: String, sku: String, pageReferrer: String? = nil, pageLocale: String? = nil) -> Page {
        Page(type: .product, location: pageLocation, data: [sku], referrer: pageReferrer, pageLocale: pageLocale)
    }

    public static func cartPage(pageLocation: String, cart: [String], pageReferrer: String? = nil, pageLocale: String? = nil) -> Page {
        Page(type: .cart, location: pageLocation, data: cart, referrer: pageReferrer, pageLocale: pageLocale)
    }

    public static func otherPage(pageLocation: String, pageReferrer: String? = nil, pageLocale: String? = nil, data: String? = nil) -> Page {
        Page(type: .other, location: pageLocation, data: data.map { [$0] } ?? [], referrer: pageReferrer, pageLocale: pageLocale)
    }

}

//
//  ScreenType.swift
//  DYLibrary
//
//  Created by Miri Kutainer on 05/06/2023.
//

import Foundation

public enum PageType: String, Codable, CaseIterable {
    case homepage = "HOMEPAGE"
    case category = "CATEGORY"
    case product = "PRODUCT"
    case cart = "CART"
    case other = "OTHER"
}

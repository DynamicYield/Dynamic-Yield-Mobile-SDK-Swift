//
//  ProductDataOptions.swift
//  DyLibrary
//
//  Created by Avi Gelkop on 20/10/2025.
//

public class ProductDataOptions: Codable {
    public var skusOnly: Bool?
    public var fieldFilter: [String]?

    public init(skusOnly: Bool? = nil, fieldFilter: [String]? = nil) {
        self.skusOnly = skusOnly
        self.fieldFilter = fieldFilter
    }

    func isEmpty() -> Bool {
        return skusOnly == nil && (fieldFilter?.isEmpty ?? true)
    }
}

//
//  Context.swift
//  DYLibrary
//
//  Created by Miri Kutainer on 23/08/2023.
//

import Foundation

public struct Context: Encodable {
    var page: Page?
    var device: Device?
    var branch: Branch?
    var channel: Channel?
    var cart: [CartItem]?
    var pageAttributes: [String: PageAttribute]?
    var listedItems: [String]?

    init(page: Page? = nil,
         device: Device? = nil,
         branch: Branch? = nil,
         channel: Channel? = nil,
         cart: [CartItem]? = nil,
         pageAttributes: [String: PageAttribute]? = nil,
         listedItems: [String]? = nil) {
        self.page = page
        self.device = device
        self.branch = branch
        self.channel = channel
        self.cart = cart
        self.pageAttributes = pageAttributes
        self.listedItems = listedItems
    }
}

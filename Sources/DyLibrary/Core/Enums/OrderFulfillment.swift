//
//  Channel.swift
//  DYLibrary
//
//  Created by Miri Kutainer on 22/05/2024.
//

import Foundation

public enum OrderFulfillment: String, Codable, CaseIterable {
    case delivery = "DELIVERY"
    case pickup = "PICKUP"
    case dinein = "DINEIN"
    case curbside = "CURBSIDE"
}

//
//  DecisionType.swift
//  DYLibrary
//
//  Created by Miri Kutainer on 05/06/2023.
//

import Foundation

public enum DecisionType: String, Codable {
    case customJSON = "CUSTOM_JSON"
    case recs = "RECS"
    case storeRecs = "STORE_RECS"
    case sorting = "SORT"
}

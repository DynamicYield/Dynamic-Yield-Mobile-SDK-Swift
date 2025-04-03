//
//  SlotListener.swift
//
//
//  Created by Miri Kutainer on 16/09/2024.
//

import Foundation

protocol SlotListener {
    func getVariationId() -> Int
    func getDecisionId() -> String
}

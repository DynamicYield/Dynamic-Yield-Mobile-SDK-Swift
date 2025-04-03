//
//  Channel.swift
//  DYLibrary
//
//  Created by Miri Kutainer on 22/05/2024.
//

import Foundation

public enum Channel: String, Codable, CaseIterable {
    case app = "APP"
    case kiosk = "KIOSK"
    case driveThru = "DRIVE-THRU"
}

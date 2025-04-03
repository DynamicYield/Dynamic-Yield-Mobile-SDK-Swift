//
//  DeviceType.swift
//  DYLibrary
//
//  Created by Miri Kutainer on 22/05/2024.
//

import Foundation

public enum DeviceType: String, Codable, CaseIterable {
    case odmb = "ODMB"
    case smartphone = "SMARTPHONE"
    case tablet = "TABLET"
    case kiosk = "KIOSK"
}

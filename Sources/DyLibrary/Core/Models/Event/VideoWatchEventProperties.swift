//
//  VideoWatchEventProperties.swift
//  DYLibrary
//
//  Created by Valeria Pivchik on 22/11/2023.
//

import Foundation

public struct VideoWatchEventProperties: EventProperties {
    public var dyType: String
    public var itemId: String
    public var categories: [String]?
    public var autoPlay: Bool
    public var progress: VideoProgressType = .videoStarted
    public var progressPercent: UInt

    public init(itemId: String, categories: [String]? = nil, autoPlay: Bool, progress: VideoProgressType, progressPercent: UInt) {
        self.dyType = "video-watch-v1"
        self.itemId = itemId
        self.categories = categories
        self.autoPlay = autoPlay
        self.progress = progress
        self.progressPercent = progressPercent
    }

    enum CodingKeys: String, CodingKey {
        case dyType
        case itemId
        case categories
        case autoPlay = "autoplay"
        case progress
        case progressPercent
    }
}

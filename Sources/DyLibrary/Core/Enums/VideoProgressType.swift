//
//  VideoProgressType.swift
//  DYLibrary
//
//  Created by Miri Kutainer on 05/06/2023.
//

import Foundation

public enum VideoProgressType: String, Codable {
    case videoStarted = "VIDEO_STARTED"
    case prerollFinished = "PREROLL_FINISHED"
    case videoFinished = "VIDEO_FINISHED"
    case videoProgress = "VIDEO_PROGRESS"
}

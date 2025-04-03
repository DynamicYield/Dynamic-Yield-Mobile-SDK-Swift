//
//  LoggerEngine.swift
//
//
//  Created by Miri Kutainer on 17/09/2024.
//

import Foundation

protocol LoggerEngine {
    var logLevel: LogLevel { get set }
    func dispatchLog(string: String, level: LogLevel)
}

//
//  LoggingStrings.swift
//  DyLibrary
//
//  Created by Avi Gelkop on 03/12/2024.
//

struct LoggingUtils {
    static func initLogMessage(_ type: Any.Type) -> String {
        "\(type) initialized"
    }

    static func sdkNotInitializedLogMessage(_ functionSignature: String) -> String {
        "\(functionSignature) Failed. SDK is not initialized"
    }

}

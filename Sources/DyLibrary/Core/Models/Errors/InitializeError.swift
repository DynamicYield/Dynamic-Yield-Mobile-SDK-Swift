//
//  InitializeError.swift
//  DyLibrary
//
//  Created by Miri Kutainer on 04/12/2024.
//

public class InitializeError: Error, CustomStringConvertible {
    public let isInitialize: Bool
    public let message: String

    init(isInitialize: Bool) {
        self.isInitialize = isInitialize
        self.message = isInitialize ? "DYSdk is already initialized" :  "DYSdk is not initialized"
    }

    public var description: String {
        self.message
    }
}

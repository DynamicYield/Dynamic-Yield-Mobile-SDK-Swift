//  EncodingPayloadError.swift
//
//
//  Created by Miri Kutainer on 22/09/2024.
//

import Foundation

public class EncodingPayloadError: Error, CustomStringConvertible {

    public let sourceError: Error?

    init(sourceError: Error?) {
        self.sourceError = sourceError
    }

    public var description: String {
        sourceError?.localizedDescription ?? "DY SDK has occured error during body encoding"
    }
}

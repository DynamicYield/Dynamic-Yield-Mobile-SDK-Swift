//  EncodingPayloadError.swift
//
//
//  Created by Miri Kutainer on 22/09/2024.
//

import Foundation

public class EncodingPayloadError: Error, CustomStringConvertible {

    public let sourceError: Error?
    public let stringError: String?

    init(sourceError: Error?) {
        self.sourceError = sourceError
        stringError = nil
    }

    init(source: String?) {
        self.stringError = source
        sourceError = nil
    }

    public var description: String {
        sourceError?.localizedDescription ?? stringError ?? "DY SDK has error during body encoding"
    }
}

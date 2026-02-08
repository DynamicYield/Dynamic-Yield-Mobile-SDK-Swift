//  DecodingResultError.swift
//
//  Created by Miri Kutainer on 22/09/2024.
//
import Foundation

public class DecodingResultError: Error, CustomStringConvertible {
    public let sourceError: Error?

    public init(sourceError: Error?) {
        self.sourceError = sourceError
    }

    public var description: String {
        sourceError?.localizedDescription ?? "DY SDK has occured error during body decoding"
    }
}

public class DecodingSemanticSearchResultError: DecodingResultError {

    public override var description: String {
        sourceError?.localizedDescription ?? "DY SDK has encountered an error during decoding SemanticSearchResult"
    }
}

public class DecodingVisualSearchResultError: DecodingResultError {

    public override var description: String {
        sourceError?.localizedDescription ?? "DY SDK has encountered an error during decoding VisualSearchResult"
    }
}

public class DecodingChooseResultError: DecodingResultError {

    public override var description: String {
        sourceError?.localizedDescription ?? "DY SDK has encountered an error during decoding ChooseResult"
    }
}

public class DecodingAssistantResultError: DecodingResultError {

    public override var description: String {
        sourceError?.localizedDescription ?? "DY SDK has encountered an error during decoding AssistantResult"
    }
}

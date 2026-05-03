//
//  InitializeError.swift
//  DyLibrary
//
//  Created by Miri Kutainer on 04/12/2024.
//

public class MissingActiveConsentError: Error, CustomStringConvertible {
    public var description: String {
        "The request is blocked because the active consent value is false " +
        "and the 'activeConsentAccepted' flag is set to true. " +
        "Please ensure active consent is accepted before sending the request."
    }
}

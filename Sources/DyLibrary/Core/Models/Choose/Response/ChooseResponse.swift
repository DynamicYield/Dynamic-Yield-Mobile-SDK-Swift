//
//  ChoiceResponse.swift
//  DYLibrary
//
//  Created by Miri Kutainer on 23/08/2023.
//

import Foundation

struct ChooseResponse: Decodable {
    public let choices: [Choice]
    public let cookies: [Cookie]
}

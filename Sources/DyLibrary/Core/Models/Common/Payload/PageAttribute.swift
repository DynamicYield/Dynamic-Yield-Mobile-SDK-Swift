//
//  PageAttribute.swift
//
//
//  Created by Miri Kutainer on 16/09/2024.
//

import Foundation

public enum PageAttribute: Encodable {
    case numberValue(Int)
    case stringValue(String)

    public init(_ value: String) {
        self = .stringValue(value)
    }

    public init(_ value: Int) {
        self = .numberValue(value)
    }

    public func encode(to encoder: Encoder) throws {
          var container = encoder.singleValueContainer()
          switch self {
          case .numberValue(let number):
              try container.encode(number)
          case .stringValue(let string):
              try container.encode(string)
          }
      }
}

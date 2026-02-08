//
//  Facet.swift
//  DyLibrary
//
//  Created by Miri Kutainer on 19/10/2025.
//

public struct StringFacetValue: Decodable {
    public let name: String
    public let count: Int

    public init(name: String, count: Int) {
        self.name = name
        self.count = count
    }
}

// MARK: - Choice Protocol
public protocol Facet: Decodable {

    var column: String { get }
    var displayName: String { get }
    var valuesType: FacetValuesType { get }

}

public class NumberFacet: Facet {

    public var column: String

    public var displayName: String

    public var valuesType: FacetValuesType

    public let min: Float

    public let max: Float

    init(column: String, displayName: String, min: Float, max: Float) {
        self.column = column
        self.displayName = displayName
        self.valuesType = FacetValuesType.number
        self.min = min
        self.max = max
    }

}

public class StringFacet: Facet {

    public var column: String

    public var displayName: String

    public var valuesType: FacetValuesType

    public let values: [StringFacetValue]

    init(column: String, displayName: String, values: [StringFacetValue]) {
        self.column = column
        self.displayName = displayName
        self.valuesType = FacetValuesType.string
        self.values = values
    }

}

public enum AnyFacet: Decodable {
    case number(NumberFacet)
    case string(StringFacet)

    public var facet: any Facet {
        switch self {
        case .number(let c): return c
        case .string(let c): return c
        }
    }

    private enum CodingKeys: String, CodingKey {
        case valuesType
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let valuesType = try container.decode(FacetValuesType.self, forKey: .valuesType)
        switch valuesType {
        case .number:
            self =  .number(try NumberFacet(from: decoder))
        case .string:
            self =  .string(try StringFacet(from: decoder))
        }
    }
}

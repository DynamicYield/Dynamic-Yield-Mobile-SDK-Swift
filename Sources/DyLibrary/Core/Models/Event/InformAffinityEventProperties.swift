//
//  InformAffinityEventProperties.swift
//  DyLibrary
//
//  Created by Miri Kutainer on 25/09/2024.
//

public struct InformAffinityEventProperties: EventProperties {

    public var dyType: String
    var source: String?
    var data: [InformAffinityData]

    public init(source: String? = nil, data: [InformAffinityData]) {
        self.dyType  = "inform-affinity-v1"
        self.source = source
        self.data = data
    }
}

public struct InformAffinityData: Encodable {
    var attribute: String?
    var values: [String]

    public init(attribute: String? = nil, values: [String]) {
        self.attribute = attribute
        self.values = values
    }
}

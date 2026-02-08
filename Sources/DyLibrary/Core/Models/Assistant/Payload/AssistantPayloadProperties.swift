//
//  AssistantOptions.swift
//  DyLibrary
//
//  Created by Avi Gelkop on 20/10/2025.
//

/// Represents options for Assistant requests.
public struct AssistantOptions: Encodable {
    public let returnAnalyticsMetadata: Bool?
    public let productData: AssistantProductDataOptions?

    public init(returnAnalyticsMetadata: Bool? = nil, productData: AssistantProductDataOptions? = nil) {
        self.returnAnalyticsMetadata = returnAnalyticsMetadata
        self.productData = productData
    }

    func isEmpty() -> Bool {
        return returnAnalyticsMetadata == nil && productData?.isEmpty() ?? true
    }
}

public class AssistantProductDataOptions: ProductDataOptions {}

struct AssistantQuery: Encodable {
    let text: String
    let chatId: String?
}

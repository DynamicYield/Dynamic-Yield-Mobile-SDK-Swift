//
//  SearchModel.swift
//
//
//  Created by Miri Kutainer on 17/09/2024.
//

import Foundation

/// Model class for Search requests
///
public class SearchModel: EndpointModelProtocol {

    var logger: DYLogger
    var logCategory = "Search Endpoint"

    var endpointModelProvider: EndpointModelProvider
    var httpMethod = HttpMethod.post
    var urlMethod = EndpointModelUtils.searchUrl

    private let page: Page
    internal let query: SearchQuery
    private let pageAttributes: [String: PageAttribute]?
    private let branchId: String?
    private let options: SearchOptions?
    private let addDeviceDateTime: Bool

    public init(
        endpointModelProvider: EndpointModelProvider,
        page: Page,
        query: SearchQuery,
        pageAttributes: [String: PageAttribute]? = nil,
        branchId: String? = nil,
        options: SearchOptions? = nil,
        addDeviceDateTime: Bool = true
    ) {
        self.endpointModelProvider = endpointModelProvider
        self.page = page
        self.query = query
        self.pageAttributes  = pageAttributes
        self.branchId = branchId
        self.options = options
        self.addDeviceDateTime = addDeviceDateTime

        logger = DYLogger(logCategory: logCategory)
        logger.log(LoggingUtils.initLogMessage(type(of: self)))
    }

    func encodingFailureMessage() -> String {
        "encode payload object for search variation"
    }

    func getNetworkFailureMessage() -> String {
        "failed get search variations for query: \(String(describing: query))"
    }

    public func getPayload() throws -> Data? {
        let device = Device(
            type: endpointModelProvider.getExperienceConfig().deviceType,
            ip: endpointModelProvider.getExperienceConfig().ip,
            id: endpointModelProvider.getExperienceConfig().deviceId,
            addDateTime: addDeviceDateTime
        )

        if page.locale == nil {
            page.locale = endpointModelProvider.getExperienceConfig().defaultLocale
        }

        let context = Context(
            page: page,
            device: device,
            branch: (branchId != nil) ? Branch(
                id: branchId
            ) : nil,
            channel: endpointModelProvider.getExperienceConfig().channel,
            pageAttributes: pageAttributes
        )

        let selector =  switch query {
        case .semanticQuery:
            SearchSelector(name: SearchType.semantic)
        case .visualQuery:
            SearchSelector(name: SearchType.visual)
        }

        let searchPayloadData = SearchPayload(
            session: endpointModelProvider.getSession(),
            user: endpointModelProvider.getUser(cuid: nil, cuidType: nil),
            selector: selector,
            context: context,
            query: query,
            options: options
        )

        return try endpointModelProvider.encodingPayload(payload: searchPayloadData)
    }
}

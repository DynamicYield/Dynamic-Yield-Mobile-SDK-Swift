//
//  EngagementsManager.swift
//
//
//  Created by Miri Kutainer on 22/09/2024.
//

import Foundation

/// Manages the Engagements API, sends requests, and returns results.
///

public class EngagementsManager: EndpointManagerProtocol {
    var logger: DYLogger

    let endpointManagerProvider: EndpointManagerProvider

    var encodingManager = EncodingManager()

    var decodingManager = DecodingManager()

    var logCategory = "Engagement Manager"

    // MARK: Init

    init(endpointManagerProvider: EndpointManagerProvider) {
        self.endpointManagerProvider = endpointManagerProvider
        logger = DYLogger(logCategory: logCategory)
        logger.log(LoggingUtils.initLogMessage(type(of: self)))
    }

    // MARK: Override methods

    func getWarnings(body: Data?) throws -> [Warning]? {
        logger.log(#function)

        guard let data = body else {
            return nil
        }

        do {
            return try decodingManager.decodeFromString(StringWarnings.self, from: data)?.warnings?.map { Warning(message: $0)}
        } catch {
            logger.log(logLevel: .error, "Failed to decode warnings")
            throw error
        }
    }

    // MARK: API

    public func reportEngagement(
        engagements: BaseEngagement...,
        branchId: String? = nil,
        dayPart: DayPart? = nil
    ) async -> DYResult {
        logger.log(#function)

        if !endpointManagerProvider.isSdkInitialized() {
            logger.log(logLevel: .critical, LoggingUtils.sdkNotInitializedLogMessage(#function))
            return DYChooseResult(choices: nil, status: ResultStatus.error, warning: nil, error: InitializeError(isInitialize: false), rawNetworkData: nil)
        }

        let endpoint = EngagementModel(
            endpointModelProvider: endpointModelProvider,
            engagements: engagements,
            branchId: branchId,
            dayPart: dayPart
        )
        return await sendRequest(endpoint: endpoint)
    }

    public func reportClick(
        decisionId: String,
        variation: Int? = nil,
        branchId: String? = nil,
        dayPart: DayPart? = nil
    ) async -> DYResult {
        logger.log(#function)

        return await reportEngagement(
            engagements: ClickEngagement(decisionId: decisionId, variations: variation != nil ? [variation!] : nil),
            branchId: branchId,
            dayPart: dayPart
        )
    }

    public func reportImpression(
        decisionId: String,
        variations: [Int]? = nil,
        branchId: String? = nil,
        dayPart: DayPart? = nil
    ) async -> DYResult {
        logger.log(#function)
        return await reportEngagement(
            engagements: ImpressionEngagement(decisionId: decisionId, variations: variations),
            dayPart: dayPart
        )
    }

    public func reportSlotClick(
        variation: Int?,
        slotId: String,
        branchId: String? = nil,
        dayPart: DayPart? = nil
    ) async -> DYResult {
        logger.log(#function)

        return await reportEngagement(
            engagements: SlotClickEngagement(
                variations: (variation != nil) ? [variation!] : nil,
                slotId: slotId
            ), branchId: branchId, dayPart: dayPart
        )
    }

    public func reportSlotImpression(
        variation: Int? = nil,
        slotsIds: [String],
        branchId: String? = nil,
        dayPart: DayPart? = nil
    ) async -> DYResult {
        logger.log(#function)

        return await reportEngagement(
            engagements: SlotImpressionEngagement(
                variations: (variation != nil) ? [variation!] : nil,
                slotsIds: slotsIds
            ), dayPart: dayPart
        )
    }

    public func reportPnEngagement(
        trackingData: TrackingData
    ) async -> DYResult {
        logger.log(#function)

        return await reportEngagement(
            engagements: EngagementPN(trackingData: trackingData)
        )
    }
}

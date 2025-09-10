//
//  EngagementsExtensions.swift
//  DyLibrary
//
//  Created by Miri Kutainer on 25/09/2024.
//

extension Variation {
    public func reportClick(branchId: String? = nil, dayPart: DayPart? = nil) async -> DYResult {
        await DYSdk.shared().engagements.reportClick(
            decisionId: decisionId,
            variation: self.id,
            branchId: branchId,
            dayPart: dayPart
        )
    }

    public func reportImpression(branchId: String? = nil, dayPart: DayPart? = nil) async -> DYResult {
        await DYSdk.shared().engagements.reportImpression(
            decisionId: decisionId,
            variations: [id],
            branchId: branchId,
            dayPart: dayPart
        )
    }
}

extension Slot {
    public func reportClick(branchId: String? = nil, dayPart: DayPart? = nil) async -> DYResult {
        await DYSdk.shared().engagements.reportSlotClick(
            variation: variationId,
            slotId: slotId,
            branchId: branchId,
            dayPart: dayPart
        )
    }
}

extension StoreRecsVariation {
    public func reportSlotsImpression(branchId: String? = nil, dayPart: DayPart? = nil, slotsIds: [String]) async -> DYResult {
        await DYSdk.shared().engagements.reportSlotsImpression(
            variation: id,
            slotsIds: slotsIds,
            branchId: branchId,
            dayPart: dayPart
        )
    }
}

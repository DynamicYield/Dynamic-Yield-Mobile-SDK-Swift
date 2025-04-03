//
//  ExperienceConfig.swift
//
//
//  Created by Miri Kutainer on 17/09/2024.
//

import Foundation

public struct ExperienceConfig {
    let dataCenter: DataCenter
    public internal(set) var sharedDevice: Bool?
    public internal(set) var deviceType: DeviceType?
    public internal(set) var deviceId: String?
    public internal(set) var channel: Channel = Channel.app
    public internal(set) var ip: String?
    public internal(set) var defaultLocale: String?
    public internal(set) var isImplicitPageview: Bool?
    public internal(set) var isImplicitImpressionMode: Bool?
    public internal(set) var customUrl: String?

    private let logger = DYLogger(logCategory: "ExperienceConfig")

    public init(
        dataCenter: DataCenter,
        sharedDevice: Bool? = nil,
        deviceType: DeviceType? = nil,
        deviceId: String? = nil,
        channel: Channel = Channel.app,
        ip: String? = nil,
        defaultLocale: String? = nil,
        isImplicitPageview: Bool? = nil,
        isImplicitImpressionMode: Bool? = nil,
        customUrl: String? = nil
    ) {
        logger.log(LoggingUtils.initLogMessage(type(of: self)))

        self.dataCenter = dataCenter
        self.sharedDevice = sharedDevice
        self.deviceType = deviceType
        self.deviceId = deviceId
        self.channel = channel
        self.ip = ip
        self.defaultLocale = defaultLocale
        self.isImplicitPageview = isImplicitPageview
        self.isImplicitImpressionMode = isImplicitImpressionMode
        self.customUrl = customUrl
    }
}

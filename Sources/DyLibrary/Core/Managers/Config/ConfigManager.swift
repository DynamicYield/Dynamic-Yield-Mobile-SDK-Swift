//
//  ConfigManager.swift
//
//
//  Created by Miri Kutainer on 17/09/2024.
//

import Foundation

class ConfigManager {

    internal var experienceConfig: ExperienceConfig
    private let logger = DYLogger(logCategory: "Config Manager", logLevel: .debug)

    internal init(
        dataCenter: DataCenter,
        deviceType: DeviceType? = nil,
        sharedDevice: Bool? = nil,
        deviceId: String? = nil,
        channel: Channel = Channel.app,
        ip: String? = nil,
        locale: String? = nil,
        isImplicitPageview: Bool? = nil,
        isImplicitImpressionMode: Bool? = nil,
        customUrl: String? = nil
    ) {
        logger.log(logLevel: .trace, LoggingUtils.initLogMessage(type(of: self)))

        self.experienceConfig = ExperienceConfig(
            dataCenter: dataCenter,
            sharedDevice: sharedDevice,
            deviceType: deviceType,
            deviceId: deviceId,
            channel: channel,
            ip: ip,
            defaultLocale: locale,
            isImplicitPageview: isImplicitPageview,
            isImplicitImpressionMode: isImplicitImpressionMode,
            customUrl: customUrl
        )
    }

    internal func setDeviceType(_ value: DeviceType) {
        logger.log("Changing deviceType to: \(value)")
        experienceConfig.deviceType = value
    }

    internal func setDeviceId(_ value: String?) {
        logger.log("Changing deviceId to: \(String(describing: value))")
        experienceConfig.deviceId = value
    }

    internal func setChannel(_ value: Channel) {
        logger.log("Changing channel to: \(value)")
        experienceConfig.channel = value
    }

    internal func setIp(_ value: String?) {
        logger.log("Changing ip to: \(String(describing: value))")
        experienceConfig.ip = value
    }

    internal func setLocale(_ value: String?) {
        logger.log("Changing defaultLocale to: \(String(describing: value))")
        experienceConfig.defaultLocale = value
    }

    internal func setIsImplicitPageview(_ value: Bool?) {
        logger.log("Changing isImplicitPageview to: \(String(describing: value))")
        experienceConfig.isImplicitPageview = value
    }

    internal func setIsImplicitImpressionMode(_ value: Bool?) {
        logger.log("Changing isImplicitImpressionMode to: \(String(describing: value))")
        experienceConfig.isImplicitImpressionMode = value
    }

    internal func getExperienceConfig() -> ExperienceConfig {
        experienceConfig
    }
}

//
//  SessionAndUserManagerListener.swift
//  DyLibrary
//
//  Created by Miri Kutainer on 16/04/2026.
//

protocol SessionAndUserManagerProvider {
    func getActiveConsentIntegration() -> Bool
    func getActiveConsentAccepted() -> Bool?
}

struct SessionAndUserManagerProviderImplementation: SessionAndUserManagerProvider {
    private var configManager: ConfigManager

    init(configManager: ConfigManager) {
        self.configManager = configManager
    }

    func getActiveConsentIntegration() -> Bool {
        return configManager.getExperienceConfig().activeConsentIntegration
    }

    func getActiveConsentAccepted() -> Bool? {
        return configManager.getExperienceConfig().activeConsentAccepted
    }
}

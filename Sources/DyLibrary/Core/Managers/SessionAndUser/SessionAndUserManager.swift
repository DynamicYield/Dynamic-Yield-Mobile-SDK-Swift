//
//  SessionAndUserManager.swift
//
//
//  Created by Miri Kutainer on 08/07/2024.
//

import Foundation

class SessionAndUserManager {

    // MARK: Fields

    private let sessionAndUserManagerProvider: SessionAndUserManagerProvider
    private var sharedDevice: Bool?
    private let storageManager: StorageManager

    private let logger = DYLogger(logCategory: "SessionAndUserManager", logLevel: .debug)

    // MARK: Init

    public init(sessionAndUserManagerProvider: SessionAndUserManagerProvider, sharedDevice: Bool? = nil, userDefaults: UserDefaults = UserDefaults.standard) {
        logger.log(logLevel: .trace, LoggingUtils.initLogMessage(type(of: self)))
        self.sessionAndUserManagerProvider = sessionAndUserManagerProvider
        self.sharedDevice = sharedDevice
        self.storageManager = StorageManager(userDefaults: userDefaults)

        if sharedDevice == true {
            if !storageManager.getUserId().isEmpty {
                logger.log("Initialization SessionAndUserManager: User is on a shared device, removing the old DY ID since shared devices don't have a persistent DY ID user.")
                resetUserId()
            }
        } else if sessionAndUserManagerProvider.getActiveConsentIntegration() && sessionAndUserManagerProvider.getActiveConsentAccepted() != true {
            logger.log("Initialization SessionAndUserManager: User has not accepted the consent, resetting session and user data.")
            resetSessionId()
            resetUserId()
        }
    }

    // MARK: Methods

    func getUser(cuid: String? = nil, cuidType: String? = nil) -> User {

        logger.log("\(#function)")
        return User(dyid: storageManager.getUserId(), sharedDevice: sharedDevice, cuid: cuid, cuidType: cuidType, activeConsentAccepted: getActiveConsentAcceptedValue())
    }

    func getSession() -> Session {
        logger.log("\(#function)")
        return Session(dy: storageManager.getSessionId())
    }

    func resetUserId() {
        logger.log("\(#function)")
        storageManager.removeUserId()
    }

    func resetSessionId() {
        logger.log("\(#function)")
        storageManager.removeSessionId()
    }

    func updateCookies(cookies: [Cookie]?) -> Bool {
        logger.log("\(#function)")

        if sharedDevice != true && sessionAndUserManagerProvider.getActiveConsentIntegration() && sessionAndUserManagerProvider.getActiveConsentAccepted() != true {
            logger.log("updateCookies: User has not accepted the consent, cookies will not be updated.")
            return true
        }

        var successWriteSession: Bool?

        if let cookie = cookies?.first(where: {$0.name ==  "_dyjsession" }) {
            successWriteSession = try? storageManager.writeSessionId(sessionId: cookie.value, maxAge: cookie.maxAge)
        }

        if sharedDevice == true {
            logger.log("\(#function) success? -> \(successWriteSession == true)")
            return successWriteSession == true
        }

        var successWriteUserId: Bool?

        if let cookie = cookies?.first(where: {$0.name ==  "_dyid_server" }) {
            successWriteUserId = try? storageManager.writeUserId(userId: cookie.value, maxAge: cookie.maxAge)
        }

        let result = successWriteUserId == true && successWriteSession == true
        logger.log("\(#function) success? -> \(result)")
        return result
    }

    func getActiveConsentAcceptedValue() -> Bool? {
        logger.log("\(#function)")
        if sharedDevice == true || !sessionAndUserManagerProvider.getActiveConsentIntegration() {
            return nil
        } else {
            return sessionAndUserManagerProvider.getActiveConsentAccepted() ?? false
        }
    }

    func updateActiveConsentAccepted(value: Bool?) {

        logger.log("\(#function)")

        if sharedDevice == true {
            logger.log("${::updateActiveConsentAccepted.name}: Ignore when shared device is true.")
            return
        }

        logger.log("${::updateActiveConsentAccepted.name}: Changing activeConsentAccepted to: $value")

        if sessionAndUserManagerProvider.getActiveConsentIntegration() && value != true {
            logger.log("updateActiveConsentAccepted: User has not accepted the consent, resetting session and user data.")
            resetSessionId()
            resetUserId()
        }
    }
}

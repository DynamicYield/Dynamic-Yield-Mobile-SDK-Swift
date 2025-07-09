//
//  SessionAndUserManager.swift
//
//
//  Created by Miri Kutainer on 08/07/2024.
//

import Foundation

class SessionAndUserManager {

    // MARK: Fields

    private var sharedDevice: Bool?
    private let storageManager: StorageManager

    private let logger = DYLogger(logCategory: "SessionAndUserManager", logLevel: .debug)

    // MARK: Init

    public init(sharedDevice: Bool? = false, userDefaults: UserDefaults = UserDefaults.standard) {
        logger.log(logLevel: .trace, LoggingUtils.initLogMessage(type(of: self)))
        self.sharedDevice = sharedDevice
        self.storageManager = StorageManager(userDefaults: userDefaults)
    }

    // MARK: SessionAndUserManager

    func getUser(cuid: String? = nil, cuidType: String? = nil) -> User {
        let dyid = storageManager.getUserId()
        logger.log("\(#function) -> \(dyid)")
        return User(dyid: dyid, sharedDevice: sharedDevice, cuid: cuid, cuidType: cuidType)
    }

    func getSession() -> Session {
        let session = storageManager.getUserId()
        logger.log("\(#function) -> \(session)")
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
        logger.log("\(#function): \(String(describing: cookies))")

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
}

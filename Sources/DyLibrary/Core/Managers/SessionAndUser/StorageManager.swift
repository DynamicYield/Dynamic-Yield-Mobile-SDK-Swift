//
//  StorageManager.swift
//
//
//  Created by Miri Kutainer on 08/07/2024.
//

import Foundation

class StorageManager {
    private static let dyidKey = "dyid"
    private static let sessionKey = "session"
    private static let expirationKeySuffix = "_expiration"
    private static let halfHour: TimeInterval = 30 * 60 // 30 minutes in seconds
    private static let year: TimeInterval = 31556926

    private let userDefaults: UserDefaults
    private var userId: String?
    private var userIdExpiryTime: Date?
    private var sessionId: String?
    private var sessionIdExpiryTime: Date?

    private let logger = DYLogger(logCategory: "StorageManager", logLevel: .debug)

    init(userDefaults: UserDefaults) {
        logger.log(logLevel: .trace, LoggingUtils.initLogMessage(type(of: self)))

        self.userDefaults = userDefaults

        self.userId = get(forKey: StorageManager.dyidKey, as: String.self)
        self.userIdExpiryTime = get(forKey: StorageManager.dyidKey + StorageManager.expirationKeySuffix, as: Date.self)

        self.sessionId = get(forKey: StorageManager.sessionKey, as: String.self)
        self.sessionIdExpiryTime = get(forKey: StorageManager.sessionKey + StorageManager.expirationKeySuffix, as: Date.self)
    }

    func writeUserId(userId: String, maxAge: String?) throws -> Bool {
        let expirtyTime = if let maxAge = maxAge, let maxAgeDouble = Double(maxAge) {
            maxAgeDouble
        } else {
            StorageManager.year
        }

        let expirationDate = Date().addingTimeInterval(expirtyTime)
        do {
            try set(userId, forKey: StorageManager.dyidKey, expirationDate: expirationDate)
            self.userId = userId
            self.userIdExpiryTime = expirationDate
            logger.log("current dyid \(userId) maxAge \(DateFormatter().string(from: expirationDate))")
            return true
        } catch {
            logger.log(logLevel: .error, "failed to write dyid \(userId) to storage")
            throw error
        }
    }

    func writeSessionId(sessionId: String, maxAge: String?) throws -> Bool {

        let expirtyTime = if let maxAge = maxAge, let maxAgeDouble = Double(maxAge) {
            maxAgeDouble
        } else {
            StorageManager.halfHour
        }

        let expirationDate = Date().addingTimeInterval(expirtyTime)
        do {
            try set(sessionId, forKey: StorageManager.sessionKey, expirationDate: expirationDate)

            self.sessionId = sessionId
            self.sessionIdExpiryTime = expirationDate
            logger.log("current sessionId \(sessionId) maxAge \(DateFormatter().string(from: expirationDate))")
            return true
        } catch {
            logger.log(logLevel: .error, "failed to writesessionIddyid \(sessionId) to storage")
            throw error
        }
    }

    func getSessionId() -> String? {
        logger.log(logLevel: .trace, #function)

        if isDataExpired(sessionIdExpiryTime: sessionIdExpiryTime, currentTime: Date()) {
            userDefaults.removeObject(forKey: StorageManager.sessionKey)
            userDefaults.removeObject(forKey: StorageManager.sessionKey + StorageManager.expirationKeySuffix)

            self.sessionId = nil
            self.sessionIdExpiryTime = nil
        }
        return sessionId ?? ""
    }

    func getUserId() -> String {
        logger.log(logLevel: .trace, #function)

        if isDataExpired(sessionIdExpiryTime: userIdExpiryTime, currentTime: Date()) {

            userDefaults.removeObject(forKey: StorageManager.dyidKey)
            userDefaults.removeObject(forKey: StorageManager.dyidKey + StorageManager.expirationKeySuffix)

            userId = nil
            userIdExpiryTime = nil
        }

        return userId ?? ""
    }

    func clearStorageManager() {
        logger.log(logLevel: .trace, #function)

        remove(forKey: StorageManager.sessionKey)
        remove(forKey: StorageManager.dyidKey)
        remove(forKey: StorageManager.sessionKey + StorageManager.expirationKeySuffix)
        remove(forKey: StorageManager.dyidKey + StorageManager.expirationKeySuffix)
        sessionId = nil
        sessionIdExpiryTime = nil
        userId = nil
        userIdExpiryTime = nil
    }

    func removeUserId() {
        logger.log(logLevel: .trace, #function)
        remove(forKey: StorageManager.dyidKey)
        remove(forKey: StorageManager.dyidKey + StorageManager.expirationKeySuffix)
        userId = nil
        userIdExpiryTime = nil
    }

    func removeSessionId() {
        logger.log(logLevel: .trace, #function)

        remove(forKey: StorageManager.sessionKey)
        remove(forKey: StorageManager.sessionKey + StorageManager.expirationKeySuffix)
        sessionId = nil
        sessionIdExpiryTime = nil
    }

    private func set<T: Codable>(_ value: T, forKey key: String, expirationDate: Date) throws {
        logger.log(logLevel: .trace, #function)

        let encoder = JSONEncoder()
        let encoded = try encoder.encode(value)
        userDefaults.set(encoded, forKey: key)
        userDefaults.set(expirationDate, forKey: key + StorageManager.expirationKeySuffix)
    }

    private func get<T: Codable>(forKey key: String, as type: T.Type) -> T? {
        logger.log(logLevel: .trace, #function)

        if let data = userDefaults.data(forKey: key) {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode(T.self, from: data) {
                return decoded
            }
        }
        return nil
    }

    private func remove(forKey key: String) {
        logger.log(logLevel: .trace, #function)

        userDefaults.removeObject(forKey: key)
        userDefaults.removeObject(forKey: key + StorageManager.expirationKeySuffix)
    }

    private func isDataExpired(sessionIdExpiryTime: Date?, currentTime: Date) -> Bool {

        return if let sessionIdExpiryTime = sessionIdExpiryTime {
            sessionIdExpiryTime <= currentTime
        } else {
            false
        }
    }
}

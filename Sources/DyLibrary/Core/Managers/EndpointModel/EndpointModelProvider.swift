//
//  EndpointModelProvider.swift
//
//
//  Created by Miri Kutainer on 17/09/2024.
//

import Foundation

/// A protocol that contain all the required functions that some EndpointModel needs
///
/// Its being created in the EndpointManagerProtocol and has information that came from the EndpointManagerProvider, and implementations from the concrete EnpointManager themself.

public protocol EndpointModelProvider {
    func getSession() -> Session
    func getUser(cuid: String?, cuidType: String?) -> User
    func getExperienceConfig() -> ExperienceConfig
    func decodingWarnings(body: Data?) throws -> [Warning]?
    func encodingPayload(payload: EndpointPayload) throws -> Data?
}

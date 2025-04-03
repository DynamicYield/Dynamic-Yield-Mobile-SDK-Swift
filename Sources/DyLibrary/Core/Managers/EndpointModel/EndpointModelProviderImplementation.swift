import Foundation

struct EndpointModelProviderImplementation: EndpointModelProvider {

    private let getSessionClosure: () -> Session
    private let getUserClosure: () -> User
    private let getExperienceConfigClosure: () -> ExperienceConfig
    private let encodingPayloadClosure: (EndpointPayload) throws -> Data?
    private let decodingWarnings: (Data?) throws -> [Warning]?
    init(
        getSession: @escaping () -> Session,
        getUser: @escaping () -> User,
        getExperienceConfig: @escaping () -> ExperienceConfig,
        encodingPayload: @escaping (EndpointPayload) throws -> Data?,
        decodingWarnings: @escaping (Data?) throws -> [Warning]?
    ) {
        self.getSessionClosure = getSession
        self.getUserClosure = getUser
        self.getExperienceConfigClosure = getExperienceConfig
        self.encodingPayloadClosure = encodingPayload
        self.decodingWarnings = decodingWarnings
    }

    func getSession() -> Session {
        getSessionClosure()
    }

    func getUser() -> User {
        getUserClosure()
    }

    func getExperienceConfig() -> ExperienceConfig {
         getExperienceConfigClosure()
    }

    func encodingPayload(payload: any EndpointPayload) throws -> Data? {
        try encodingPayloadClosure(payload)
    }

    func decodingWarnings(body: Data?) throws -> [Warning]? {
        try decodingWarnings(body)
    }
}

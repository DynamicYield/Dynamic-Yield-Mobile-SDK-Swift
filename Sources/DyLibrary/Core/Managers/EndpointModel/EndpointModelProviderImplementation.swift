import Foundation

struct EndpointModelProviderImplementation: EndpointModelProvider {

    private let getSessionClosure: () -> Session
    private let getUserClosure: (String?, String?) -> User
    private let getExperienceConfigClosure: () -> ExperienceConfig
    private let encodingPayloadClosure: (EndpointPayload) throws -> Data?
    private let decodingWarnings: (Data?) throws -> [Warning]?
    init(
        getSession: @escaping () -> Session,
        getUser: @escaping (String?, String?) -> User,
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

    func getUser(cuid: String? = nil, cuidType: String? = nil) -> User {
        getUserClosure(cuid, cuidType)
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

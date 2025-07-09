import Foundation

struct EndpointManagerProviderImplementation: EndpointManagerProvider {

    private var configManager: ConfigManager
    private var networkManager: NetworkManager
    private var sessionAndUserManager: SessionAndUserManager
    private var networkRequestProvider: any NetworkRequestProvider
    private let initialized: Bool

    init(configManager: ConfigManager, networkManager: NetworkManager, sessionAndUserManager: SessionAndUserManager, networkRequestProvider: any NetworkRequestProvider, initialized: Bool) {
        self.configManager = configManager
        self.networkManager = networkManager
        self.sessionAndUserManager = sessionAndUserManager
        self.networkRequestProvider = networkRequestProvider
        self.initialized = initialized
    }

    // MARK: Experience

    func getSession() -> Session {
        sessionAndUserManager.getSession()
    }

    func getUser(cuid: String?, cuidType: String?) -> User {
        sessionAndUserManager.getUser(cuid: cuid, cuidType: cuidType)
    }

    func getExperienceConfig() -> ExperienceConfig {
        configManager.getExperienceConfig()
    }

    func updateCookies(cookies: [Cookie]?) -> Bool {
        sessionAndUserManager.updateCookies(cookies: cookies)
    }

    func sendRequest(endpointModel: any EndpointModelProtocol) async throws -> RawNetworkData {
        try await networkManager.sendRequest(endpointModel: endpointModel, networkRequestProvider: networkRequestProvider)
    }

    func isSdkInitialized() -> Bool {
        initialized
    }
}

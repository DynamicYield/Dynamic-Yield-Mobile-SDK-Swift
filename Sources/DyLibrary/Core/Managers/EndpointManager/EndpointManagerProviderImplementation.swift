import Foundation

struct EndpointManagerProviderImplementation: EndpointManagerProvider {

    private var configManager: ConfigManager
    private var networkManager: NetworkManager
    private var sessionAndUserManager: SessionAndUserManager
    private var networkRequestProvider: any NetworkRequestProvider

    init(configManager: ConfigManager, networkManager: NetworkManager, sessionAndUserManager: SessionAndUserManager, networkRequestProvider: any NetworkRequestProvider) {
        self.configManager = configManager
        self.networkManager = networkManager
        self.sessionAndUserManager = sessionAndUserManager
        self.networkRequestProvider = networkRequestProvider
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
}

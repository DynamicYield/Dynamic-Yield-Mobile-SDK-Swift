protocol EndpointManagerProvider {
    func getSession() -> Session
    func getUser(cuid: String?, cuidType: String?) -> User
    func getExperienceConfig() -> ExperienceConfig
    func updateCookies(cookies: [Cookie]?) -> Bool
    func sendRequest(endpointModel: any EndpointModelProtocol) async throws -> RawNetworkData
    func isSdkInitialized() -> Bool
}

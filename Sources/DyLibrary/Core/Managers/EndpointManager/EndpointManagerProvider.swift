protocol EndpointManagerProvider {
    func getSession() -> Session
    func getUser() -> User
    func getExperienceConfig() -> ExperienceConfig
    func updateCookies(cookies: [Cookie]?) -> Bool
    func sendRequest(endpointModel: any EndpointModelProtocol) async throws -> RawNetworkData
    func isSdkInitialized() -> Bool
}

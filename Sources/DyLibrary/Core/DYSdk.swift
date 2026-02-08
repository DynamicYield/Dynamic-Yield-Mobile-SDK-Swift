//
//  DYSdk.swift
//
//
//  Created by Miri Kutainer on 19/09/2024.
//

import Foundation

public class DYSdk {

    private static var _defaultSDK: DYSdk?
    private static var defaultSDK: DYSdk {
        initQueue.sync {
            if let sdk = _defaultSDK {
                return sdk
            }
            _defaultSDK = DYSdk(apiKey: "", dataCenter: .eu, version: DyVersion(Version.major, Version.minor, Version.patch), initialized: false)
            return _defaultSDK!
        }
    }

    internal static var isDebugMode: DebugMode?
    private static var instance: DYSdk?
    private static var initialized = false

    private static var logLevel: LogLevel = .warning
    private var loggerEngine: LoggerEngine
    private let logger = DYLogger(logCategory: "DYSdk")

    private let endpointManagerProvider: EndpointManagerProvider
    private let configManager: ConfigManager
    internal let networkManager: NetworkManager
    internal let sessionAndUserManager: SessionAndUserManager

    public let events: EventsManager
    public let engagements: EngagementsManager
    public let pageViews: PageViewManager
    public let choose: ChooseManager
    public let search: SearchManager
    public let assistant: AssistantManager
    internal let version: DyVersion

    private static let initQueue = DispatchQueue(label: "com.dy.initQueue")

    // You should not init the DYSdk here. Use `static func initialize`.
    private init(apiKey: String,
                 dataCenter: DataCenter,
                 deviceType: DeviceType? = nil,
                 sharedDevice: Bool? = nil,
                 deviceId: String? = nil,
                 channel: Channel = Channel.app,
                 ip: String? = nil,
                 locale: String? = nil,
                 isImplicitPageview: Bool? = nil,
                 isImplicitImpressionMode: Bool? = nil,
                 version: DyVersion,
                 networkRequestProvider: any NetworkRequestProvider = HttpNetworkRequestProvider(),
                 loggerEngineManager: LoggerEngine? = nil,
                 customUrl: String? = nil,
                 initialized: Bool
    ) {

        if #available(iOS 14, macOS 11, *) {
            self.loggerEngine = SystemLoggerEngine(DYSdk.logLevel)
        } else {
            self.loggerEngine = OSLogEngine(DYSdk.logLevel)
        }
        LoggingManager.addEngine(self.loggerEngine)

        configManager = ConfigManager(dataCenter: dataCenter,
                                      deviceType: deviceType,
                                      sharedDevice: sharedDevice,
                                      deviceId: deviceId,
                                      channel: channel,
                                      ip: ip,
                                      locale: locale,
                                      isImplicitPageview: isImplicitPageview,
                                      isImplicitImpressionMode: isImplicitImpressionMode,
                                      customUrl: customUrl)

        self.version = version

        networkManager = NetworkManager(apiKey: apiKey, dyVersion: version.description, initialized: initialized)

        let sharedDevice = configManager.getExperienceConfig().sharedDevice
        sessionAndUserManager = SessionAndUserManager(sharedDevice: sharedDevice)

        endpointManagerProvider = EndpointManagerProviderImplementation(configManager: configManager, networkManager: networkManager, sessionAndUserManager: sessionAndUserManager, networkRequestProvider: networkRequestProvider)

        choose = ChooseManager(endpointManagerProvider: endpointManagerProvider)
        engagements = EngagementsManager(endpointManagerProvider: endpointManagerProvider)
        events = EventsManager(endpointManagerProvider: endpointManagerProvider)
        pageViews = PageViewManager(endpointManagerProvider: endpointManagerProvider)
        assistant = AssistantManager(endpointManagerProvider: endpointManagerProvider)
        search = SearchManager(endpointManagerProvider: endpointManagerProvider)

        DYSdk.initialized = initialized
        logger.log(LoggingUtils.initLogMessage(type(of: self)))
    }

    internal static func initialize(apiKey: String,
                                    dataCenter: DataCenter,
                                    deviceType: DeviceType? = nil,
                                    sharedDevice: Bool? = nil,
                                    deviceId: String? = nil,
                                    channel: Channel = Channel.app,
                                    ip: String? = nil,
                                    locale: String? = nil,
                                    isImplicitPageview: Bool? = nil,
                                    isImplicitImpressionMode: Bool? = nil,
                                    version: DyVersion,
                                    networkRequestProvider: any NetworkRequestProvider = HttpNetworkRequestProvider(),
                                    customUrl: String? = nil) -> Bool {
        initQueue.sync {
            guard instance == nil && initialized == false else {
                print("Singleton already initialized")
                return false
            }

            instance = DYSdk(apiKey: apiKey,
                             dataCenter: dataCenter,
                             deviceType: deviceType,
                             sharedDevice: sharedDevice,
                             deviceId: deviceId,
                             channel: channel,
                             ip: ip,
                             locale: locale,
                             isImplicitPageview: isImplicitPageview,
                             isImplicitImpressionMode: isImplicitImpressionMode,
                             version: version,
                             networkRequestProvider: networkRequestProvider,
                             customUrl: customUrl,
                             initialized: true)

            return true
        }
    }

    // Static method to initialize the singleton with parameters
    public static func initialize(apiKey: String,
                                  dataCenter: DataCenter,
                                  deviceType: DeviceType? = nil,
                                  sharedDevice: Bool? = nil,
                                  deviceId: String? = nil,
                                  channel: Channel = Channel.app,
                                  ip: String? = nil,
                                  locale: String? = nil,
                                  isImplicitPageview: Bool? = nil,
                                  isImplicitImpressionMode: Bool? = nil,
                                  customUrl: String? = nil) -> Bool {

        initialize(apiKey: apiKey,
                   dataCenter: dataCenter,
                   deviceType: deviceType,
                   sharedDevice: sharedDevice,
                   deviceId: deviceId,
                   channel: channel,
                   ip: ip,
                   locale: locale,
                   isImplicitPageview: isImplicitPageview,
                   isImplicitImpressionMode: isImplicitImpressionMode,
                   version: DyVersion(Version.major, Version.minor, Version.patch),
                   networkRequestProvider: HttpNetworkRequestProvider(),
                   customUrl: customUrl)
    }

    // Access method that requires initialization
    public static func shared() -> DYSdk {
        instance ?? {
            let error = "DYSdk singleton did not initialize. Call `DYSdk.initialize(apiKey...)` before calling shared()."
            if getDebugMode() == .debug {
                assert(false, error)
            } else {
                print(error)
            }
            return defaultSDK
        }()
    }

    public static func setLogLevel(level: LogLevel) {
        if initialized, let instance = instance {
            instance.loggerEngine.logLevel = level
        } else {
            DYSdk.logLevel = level
        }
    }

    public func getLogLevel() -> LogLevel? {
        if isInitialized() {
            loggerEngine.logLevel
        } else {
            nil
        }
    }

    public func setRequestTimeout(timeout: TimeInterval) {
        if isInitialized() {
            networkManager.timeout = timeout
        } else {
            logger.log(logLevel: .critical, InitializeError(isInitialize: false).message)
        }
    }

    public func getSessionId() -> String? {
        if isInitialized() {
            sessionAndUserManager.getSession().dy
        } else {
            nil
        }
    }

    public func getDyId() -> String? {
        if isInitialized() {
            sessionAndUserManager.getUser().dyid
        } else {
            nil
        }
    }

    public func resetSessionId() {
        if isInitialized() {
            sessionAndUserManager.resetSessionId()
        } else {
            logger.log(logLevel: .critical, InitializeError(isInitialize: false).message)
        }
    }

    public func resetUserId() {
        if isInitialized() {
            sessionAndUserManager.resetUserId()
        } else {
            logger.log(logLevel: .critical, InitializeError(isInitialize: false).message)
        }
    }

    public func resetUserIdAndSessionId() {
        if isInitialized() {
            sessionAndUserManager.resetUserId()
            sessionAndUserManager.resetSessionId()
        } else {
            logger.log(logLevel: .critical, InitializeError(isInitialize: false).message)
        }
    }

    public func setDefaultProductDataType(defaultRecsProductData: RecsProductData.Type) {
        if isInitialized() {
            AnyProductData.dynamicType = defaultRecsProductData
        } else {
            logger.log(logLevel: .critical, InitializeError(isInitialize: false).message)
        }
    }

    public func setDeviceType(_ value: DeviceType) {
        configManager.setDeviceType(value)
    }

    public func setDeviceId(_ value: String?) {
        configManager.setDeviceId(value)
    }

    public func setChannel(_ value: Channel) {
        configManager.setChannel(value)
    }

    public func setIp(_ value: String?) {
        configManager.setIp(value)
    }

    public func setLocale(_ value: String?) {
        configManager.setLocale(value)
    }

    public func setIsImplicitPageview(_ value: Bool?) {
        configManager.setIsImplicitPageview(value)
    }

    public func setIsImplicitImpressionMode(_ value: Bool?) {
        configManager.setIsImplicitImpressionMode(value)
    }

    public func getConfig() -> ExperienceConfig {
        configManager.getExperienceConfig()
    }

    public func isInitialized() -> Bool {
        return DYSdk.initialized
    }

    public static func isInitialized() -> Bool {
        return DYSdk.initialized
    }

    private static func getDebugMode() -> DebugMode {
        if let isDebugMode = isDebugMode {
            return isDebugMode
        }
#if DEBUG
        return .debug
#else
        return .release
#endif
    }

    // swiftlint:disable:next identifier_name
    public func _setHeaderInternalUse(dyVersion: String) {
        if isInitialized() {
            self.networkManager._setHeaderInternalUse(dyVersion: dyVersion)
        } else {
            logger.log(logLevel: .critical, InitializeError(isInitialize: false).message)
        }
    }
}

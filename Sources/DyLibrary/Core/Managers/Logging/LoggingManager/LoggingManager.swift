struct LoggingManager {
    static internal var engines: [LoggerEngine] = []
    static internal func addEngine(_ engine: LoggerEngine) {
        engines.append(engine)
    }

    static internal func clearEngines() {
        engines.removeAll { !($0 is SystemLoggerEngine) }
    }

    private init() {}

    static func log(logLevel: LogLevel, logCategory: String, logMessage: String) {
        for engine in LoggingManager.engines {
            if engine.logLevel != LogLevel.off && logLevel != LogLevel.off && engine.logLevel.rawValue <= logLevel .rawValue {
                engine.dispatchLog(string: description(logCategory, logMessage), level: logLevel)
            }
        }
    }

    private static func description(_ logCategory: String, _ logMessage: String) -> String {
        "DY \(logCategory): \(logMessage)"
    }
}

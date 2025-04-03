struct DYLogger {
    private var logCategory: String
    private var logLevel: LogLevel = .trace

    init(logCategory: String, logLevel: LogLevel = .trace) {
        self.logCategory = logCategory
        self.logLevel = logLevel
    }

    func log(logLevel: LogLevel? = nil, _ message: String) {
        LoggingManager.log(logLevel: logLevel ?? self.logLevel, logCategory: logCategory, logMessage: message)
    }
}

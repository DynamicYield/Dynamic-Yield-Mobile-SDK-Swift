import os.log

@available(iOS 14.0, *)
@available(macOS 11.0, *)
struct SystemLoggerEngine: LoggerEngine {
    internal var logLevel: LogLevel
    private let logger = Logger(subsystem: "com.dynamicyield.mobileSDK", category: "mobile")

    init(_ logLevel: LogLevel) {
        self.logLevel = logLevel
    }

    func dispatchLog(string: String, level: LogLevel) {
        switch logLevel {
        case .critical:
            logger.critical("\(string)")
        case .error:
            logger.error("\(string)")
        case.warning:
            logger.warning("\(string)")
        case.notice:
            logger.notice("\(string)")
        case.info:
            logger.info("\(string)")
        case.debug:
            logger.debug("\(string)")
        case.trace:
            logger.trace("\(string)")
        default:
            break
        }
    }
}

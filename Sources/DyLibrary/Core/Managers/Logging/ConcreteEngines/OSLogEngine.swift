import OSLog

struct OSLogEngine: LoggerEngine {
    internal var logLevel: LogLevel

    init(_ logLevel: LogLevel) {
        self.logLevel = logLevel
    }

    func dispatchLog(string: String, level: LogLevel) {
        switch level {
        case .critical:
            os_log("%@", log: OSLog.default, type: .fault, string)
        case .error:
            os_log("%@", log: OSLog.default, type: .error, string)
        case .warning, .notice:
            os_log("%@", log: OSLog.default, type: .default, string)
        case .info:
            os_log("%@", log: OSLog.default, type: .info, string)
        case .debug, .trace:
            os_log("%@", log: OSLog.default, type: .fault, string)
        default:
            break
        }
    }
}

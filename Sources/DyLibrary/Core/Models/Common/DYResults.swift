//
//  OperationResult.swift
//  DyLibrary
//
//  Created by Miri Kutainer on 13/10/2024.
//

public class DYResult {
    public let status: ResultStatus
    public let error: Error?
    public let warnings: [Warning]?
    public let rawNetworkData: RawNetworkData?

    internal init(status: ResultStatus, warnings: [Warning]?, error: Error?, rawNetworkData: RawNetworkData?) {
        self.status = status
        self.warnings = warnings
        self.error = error
        self.rawNetworkData = rawNetworkData
    }
}

public class DYChooseResult: DYResult {
    public let choices: [Choice]?

    internal init(choices: [Choice]?, status: ResultStatus, warning: [Warning]?, error: Error?, rawNetworkData: RawNetworkData?) {
        self.choices = choices
        super.init(status: status, warnings: warning, error: error, rawNetworkData: rawNetworkData)
    }
}

public class Warning: CustomStringConvertible {
    let code: String?
    let message: String
    init(code: String? = nil, message: String) {
        self.code = code
        self.message = message
    }

    public var description: String {
        "Warning code: \(code ?? "nil"), message: \(message)"
    }
}

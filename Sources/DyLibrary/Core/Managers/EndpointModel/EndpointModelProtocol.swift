//
//  EndpointModelProtocol.swift
//
//
//  Created by Miri Kutainer on 17/09/2024.
//

import Foundation

/// Base protocol for an EndpointModel
///
/// Declare the required functions for an EndpointModel
///
protocol EndpointModelProtocol {

    var endpointModelProvider: EndpointModelProvider { get set }
    var httpMethod: HttpMethod { get }
    var url: String { get }
    var logCategory: String { get }
    var urlMethod: String { get }

    var logger: DYLogger { get }

    func getPayload() throws -> Data?
    func getWarnings(body: Data?) throws -> [Warning]?
    func encodingFailureMessage() -> String
    func getNetworkFailureMessage() -> String
    func getStatus(code: Int?, warning: [Warning]?, error: Error?) -> ResultStatus
    func checkNetworkError(url: String?, code: Int?, body: Data) -> NetworkFailedError?
}

extension EndpointModelProtocol {
    var url: String {
        let dataCenterEndpoint = endpointModelProvider.getExperienceConfig().customUrl ?? {
            switch endpointModelProvider.getExperienceConfig().dataCenter {
            case .us: return EndpointModelUtils.endpointUS
            case .eu: return EndpointModelUtils.endpointEU
            }
        }()

        return "\(dataCenterEndpoint)/\(EndpointModelUtils.defaultApiVersion)/\(urlMethod)"
    }

    func getStatus(code: Int?, warning: [Warning]?, error: Error?) -> ResultStatus {
        var result: ResultStatus

        if let code = code, (200...299).contains(code), error == nil {
            result = (warning == nil || warning?.isEmpty == true) ? .success : .warning
        } else {
            result = .error
        }
        logger.log("\(#function): Status is \(result)")

        return result
    }

    func checkNetworkError(url: String?, code: Int?, body: Data) -> NetworkFailedError? {
        logger.log(#function)

        var result: NetworkFailedError?

        if !(code != nil && (200...299).contains(code!)) {
            result = NetworkFailedError(url: url, code: code, body: body)

            logger.log(logLevel: .error, "Network error for url \(String(describing: url)), code: \(String(describing: code)), body: \(String(data: body, encoding: .utf8) ?? "")")
        }

        return result
    }

    func getWarnings(body: Data?) throws -> [Warning]? {
        try endpointModelProvider.decodingWarnings(body: body)
    }
}

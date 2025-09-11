//
//  HttpNetwork.swift
//
//
//  Created by Miri Kutainer on 17/09/2024.
//

import Foundation

class HttpNetwork: NetworkRequest {

    let defaultTimeoutInterval: TimeInterval = 30

    let urlSession: URLSession
    var timeoutInterval: TimeInterval

    private let logger = DYLogger(logCategory: "HttpNetwork", logLevel: .info)

    init(_ timeoutInterval: TimeInterval? = nil, urlSession: URLSession = URLSession.shared) {
        logger.log(logLevel: .trace, LoggingUtils.initLogMessage(type(of: self)))
        if let timeoutInterval = timeoutInterval, timeoutInterval > 0 {
            self.timeoutInterval = timeoutInterval
        } else {
            self.timeoutInterval = defaultTimeoutInterval
        }

        self.urlSession = urlSession
    }

    func getRequest(url: String, method: HttpMethod, payload: Data?, headers: [String: String] ) async throws -> RawNetworkData {
        guard let sessionUrl = URL(string: url) else {
            let errorMessage = "Invalid URL"

            logger.log(logLevel: .error, errorMessage)
            throw NetworkError.invalidURL(message: errorMessage)
        }

        logger.log("request url: \(url), method: \(method)\n payload: \(String(data: payload ?? Data(), encoding: .utf8) ?? "nil"),\n headers: \(headers)")

        var request = URLRequest(url: sessionUrl)
        request.httpMethod = method.rawValue
        request.timeoutInterval = timeoutInterval
        // Ensure the URL is valid

        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }

        // Add the payload if needed
        if let payload = payload, method == .put || method == .post {
            request.httpBody = payload
        }
        // Perform the network request asynchronously
        let (data, response) = try await urlSession.data(for: request)

        // Ensure the response is a valid HTTP response
        guard let httpResponse = response as? HTTPURLResponse else {
            let errorMessage = "bad server response \(sessionUrl.absoluteString)"

            logger.log(logLevel: .error, errorMessage)
            throw NetworkError.badServerResponse(message: errorMessage)
        }

        let encodingBody = String(data: data, encoding: .utf8)
        logger.log("got response for url: \(url):\n code: \(httpResponse.statusCode),\n body: \(encodingBody ?? "nil")")

        return RawNetworkData(request: request, urlResponse: response, code: httpResponse.statusCode, isSuccessful: 200...299 ~= httpResponse.statusCode, body: data, sdkVersionHeader: headers[EndpointModelUtils.dySdkVersionHeader])
    }
}

public enum NetworkError: Error {
    case invalidURL(message: String)
    case badServerResponse(message: String)
}

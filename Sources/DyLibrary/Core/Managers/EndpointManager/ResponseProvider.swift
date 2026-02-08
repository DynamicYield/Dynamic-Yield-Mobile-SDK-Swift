//
//  ResponseProvider.swift
//  DyLibrary
//
//  Created by Miri Kutainer on 29/10/2025.
//

import Foundation

protocol ResponseProvider {
    associatedtype ResponseType: Response
    associatedtype ResultType: DYResult

    var campaignsResponse: ResponseType? { get set }

    func getDecodingException(sourceException: Error?) -> DecodingResultError

    func decodingFromData(
        data: Data,
        decodingManager: DecodingManager
    ) throws

    func getCookies() -> [Cookie]?

    func hasCookies() -> Bool

    func hasBody() -> Bool

    func getDYResult(
        status: ResultStatus,
        warnings: [Warning]?,
        error: Error?,
        rawNetworkData: RawNetworkData?
    ) -> ResultType

    func getErrorDYResult(error: Error) -> ResultType
}

class EmptyResponseProvider: ResponseProvider {

    typealias ResponseType = EmptyResponse

    typealias ResultType = DYResult

    var campaignsResponse: ResponseType?

    func getDYResult(status: ResultStatus, warnings: [Warning]?, error: (any Error)?, rawNetworkData: RawNetworkData?) -> ResultType {
        return ResultType(status: status, warnings: warnings, error: error, rawNetworkData: rawNetworkData)
    }

    func getErrorDYResult(error: any Error) -> ResultType {
        return ResultType(status: ResultStatus.error, warnings: nil, error: error, rawNetworkData: nil)
    }

    func getDecodingException(sourceException: (any Error)?) -> DecodingResultError {
        return DecodingResultError(sourceError: sourceException)
    }

    func decodingFromData(data: Data, decodingManager: DecodingManager) throws {

    }

    func getCookies() -> [Cookie]? {
        return nil
    }

    func hasCookies() -> Bool {
        return false
    }

    func hasBody() -> Bool {
        return false
    }

}
class ChooseResponseProvider: ResponseProvider {
    typealias ResponseType = ChooseResponse
    typealias ResultType = DYChooseResult

    var campaignsResponse: ResponseType?

    func getDecodingException(sourceException: Error?) -> DecodingResultError {
        return DecodingChooseResultError(sourceError: sourceException)
    }

    func decodingFromData(data: Data, decodingManager: DecodingManager) throws {
        do {
            self.campaignsResponse = try decodingManager.decodeFromString(ResponseType.self, from: data)
        } catch {
            throw getDecodingException(sourceException: error)
        }
    }

    func getCookies() -> [Cookie]? {
        return campaignsResponse?.cookies
    }

    func hasCookies() -> Bool {
        return true
    }

    func hasBody() -> Bool {
        return true
    }

    func getDYResult(
        status: ResultStatus,
        warnings: [Warning]?,
        error: Error?,
        rawNetworkData: RawNetworkData?
    ) -> ResultType {
        return ResultType(
            choices: campaignsResponse?.choices,
            status: status,
            warnings: warnings,
            error: error,
            rawNetworkData: rawNetworkData
        )
    }

    // Additional helper for error result, as in your Kotlin code
    func getErrorDYResult(error: Error) -> ResultType {
        return ResultType(
            choices: nil,
            status: .error,
            warnings: nil,
            error: error,
            rawNetworkData: nil
        )
    }
}

class SemanticSearchResponseProvider: ResponseProvider {
    typealias ResponseType = SemanticSearchResponse
    typealias ResultType = DYSemanticSearchResult

    var campaignsResponse: ResponseType?

    func getDecodingException(sourceException: Error?) -> DecodingResultError {
        return DecodingSemanticSearchResultError(sourceError: sourceException)
    }

    func decodingFromData(data: Data, decodingManager: DecodingManager) throws {

        do {
            self.campaignsResponse = try decodingManager.decodeFromString(SemanticSearchResponse.self, from: data)
        } catch {
            throw getDecodingException(sourceException: error)
        }
    }

    func getCookies() -> [Cookie]? {
        return campaignsResponse?.cookies
    }

    func hasCookies() -> Bool {
        return true
    }

    func hasBody() -> Bool {
        return true
    }

    func getDYResult(
        status: ResultStatus,
        warnings: [Warning]?,
        error: Error?,
        rawNetworkData: RawNetworkData?
    ) -> ResultType {
        return ResultType(
            choice: campaignsResponse?.choices.first,
            status: status,
            warnings: warnings,
            error: error,
            rawNetworkData: rawNetworkData
        )
    }

    // Additional helper for error result, as in your Kotlin code
    func getErrorDYResult(error: Error) -> ResultType {
        return ResultType(
            choice: nil,
            status: .error,
            warnings: nil,
            error: error,
            rawNetworkData: nil
        )
    }
}

class VisualSearchResponseProvider: ResponseProvider {
    typealias ResponseType = VisualSearchResponse
    typealias ResultType = DYVisualSearchResult

    var campaignsResponse: ResponseType?

    func getDecodingException(sourceException: Error?) -> DecodingResultError {
        return DecodingVisualSearchResultError(sourceError: sourceException)
    }

    func decodingFromData(data: Data, decodingManager: DecodingManager) throws {

        do {
            self.campaignsResponse = try decodingManager.decodeFromString(VisualSearchResponse.self, from: data)
        } catch {
            throw getDecodingException(sourceException: error)
        }
    }

    func getCookies() -> [Cookie]? {
        return campaignsResponse?.cookies
    }

    func hasCookies() -> Bool {
        return true
    }

    func hasBody() -> Bool {
        return true
    }

    func getDYResult(
        status: ResultStatus,
        warnings: [Warning]?,
        error: Error?,
        rawNetworkData: RawNetworkData?
    ) -> ResultType {
        return ResultType(
            choice: campaignsResponse?.choices.first,
            status: status,
            warnings: warnings,
            error: error,
            rawNetworkData: rawNetworkData
        )
    }

    // Additional helper for error result, as in your Kotlin code
    func getErrorDYResult(error: Error) -> ResultType {
        return ResultType(
            choice: nil,
            status: .error,
            warnings: nil,
            error: error,
            rawNetworkData: nil
        )
    }
}

class AssistantResponseProvider: ResponseProvider {
    typealias ResponseType = AssistantResponse
    typealias ResultType = DYAssistantResult

    var campaignsResponse: ResponseType?

    func getDecodingException(sourceException: Error?) -> DecodingResultError {
        return DecodingAssistantResultError(sourceError: sourceException)
    }

    func decodingFromData(data: Data, decodingManager: DecodingManager) throws {

        do {
            self.campaignsResponse = try decodingManager.decodeFromString(AssistantResponse.self, from: data)
        } catch {
            throw getDecodingException(sourceException: error)
        }
    }

    func getCookies() -> [Cookie]? {
        return campaignsResponse?.cookies
    }

    func hasCookies() -> Bool {
        return true
    }

    func hasBody() -> Bool {
        return true
    }

    func getDYResult(
        status: ResultStatus,
        warnings: [Warning]?,
        error: Error?,
        rawNetworkData: RawNetworkData?
    ) -> ResultType {
        return ResultType(
            choices: campaignsResponse?.choices,
            status: status,
            warnings: warnings,
            error: error,
            rawNetworkData: rawNetworkData
        )
    }

    // Additional helper for error result, as in your Kotlin code
    func getErrorDYResult(error: Error) -> ResultType {
        return ResultType(
            choices: nil,
            status: .error,
            warnings: nil,
            error: error,
            rawNetworkData: nil
        )
    }
}

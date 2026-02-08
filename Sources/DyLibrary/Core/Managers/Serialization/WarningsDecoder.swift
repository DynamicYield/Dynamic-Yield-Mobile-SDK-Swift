import Foundation

struct WarningsDecoder {
    static func decodeCodeAndMessageWarnings(body: Data?, decodingManager: DecodingManager) throws -> [Warning]? {
        guard let data = body else { return nil }

        do {
            return try decodingManager.decodeFromString(CodeAndMessageWarnings.self, from: data)?.warnings?.map { Warning(code: $0.code, message: $0.message) }
        } catch {
            throw error
        }
    }

    static func decodeStringWarnings(body: Data?, decodingManager: DecodingManager) throws -> [Warning]? {
        guard let data = body else { return nil }

        do {
            return try decodingManager.decodeFromString(StringWarnings.self, from: data)?.warnings?.map { Warning(message: $0) }
        } catch {
            throw error
        }
    }
}

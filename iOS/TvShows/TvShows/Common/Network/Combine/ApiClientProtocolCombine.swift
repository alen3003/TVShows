import Combine
import Foundation

protocol ApiClientProtocolCombine {

    func get<ResultType: Decodable>(path: String, queryParameters: [String: String]?) -> SingleCombine<ResultType, Error>

    func post<ParamsType: Encodable>(path: String, body: ParamsType) -> CompletableCombine<Error>

    func post<ParamsType: Encodable, ResultType: Decodable>(
        path: String,
        body: ParamsType
    ) -> SingleCombine<ResultType, Error>

    func put<ParamsType: Encodable>(path: String, body: ParamsType) -> CompletableCombine<Error>

    func patch<ParamsType: Encodable, ResultType: Decodable>(
        path: String,
        body: ParamsType
    ) -> SingleCombine<ResultType, Error>

    func delete(path: String, parameters: [String: String]?) -> CompletableCombine<Error>

    func buildUrl(path: String, method: HTTPMethod, parameters: [String: String]?) -> URL?

    func buildRequest(path: String, method: HTTPMethod, parameters: [String: String]?) -> URLRequest?

}

// ApiClientProtocol extension that adds support for default parameters.
extension ApiClientProtocolCombine {

    func get<ResultType: Decodable>(
        path: String,
        queryParameters: [String: String]? = nil
    ) -> SingleCombine<ResultType, Error> {
        get(path: path, queryParameters: queryParameters)
    }

    func delete(path: String, parameters: [String: String]? = nil) -> CompletableCombine<Error> {
        delete(path: path, parameters: parameters)
    }

}

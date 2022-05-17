import Combine
import Foundation

class BaseApiClientCombine: ApiClientProtocolCombine {

    private let baseUrl: String
    private let simpleApiClient: SimpleApiClient

    init(baseUrl: String, urlSession: URLSession = .shared, interceptor: RequestInterceptorProtocol? = nil) {
        self.baseUrl = baseUrl
        self.simpleApiClient = SimpleApiClient(urlSession: urlSession, interceptor: interceptor)
    }

    func get<ResultType: Decodable>(
        path: String,
        queryParameters: [String: String]? = nil
    ) -> SingleCombine<ResultType, Error> {
        simpleApiClient.executeAndReturn(url: url(with: path), method: .get, parameters: queryParameters)
    }

    func post<ParamsType: Encodable, ResultType: Decodable>(
        path: String,
        body: ParamsType
    ) -> SingleCombine<ResultType, Error> {
        simpleApiClient.executeAndReturn(url: url(with: path), method: .post, parameters: body)
    }

    func patch<ParamsType: Encodable, ResultType: Decodable>(
        path: String,
        body: ParamsType
    ) -> SingleCombine<ResultType, Error> {
        simpleApiClient.executeAndReturn(url: url(with: path), method: .patch, parameters: body)
    }

    func buildUrl(path: String, method: HTTPMethod, parameters: [String: String]?) -> URL? {
        simpleApiClient.buildUrl(url: url(with: path), method: method, parameters: parameters)
    }

    func buildRequest(path: String, method: HTTPMethod, parameters: [String: String]?) -> URLRequest? {
        simpleApiClient.buildRequest(url: url(with: path), method: method, parameters: parameters)
    }

    private func url(with path: String) -> String {
        "\(baseUrl)\(path)"
    }

}

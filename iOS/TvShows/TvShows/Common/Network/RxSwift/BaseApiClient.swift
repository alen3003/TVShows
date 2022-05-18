import Foundation
import RxCocoa
import RxSwift

class BaseApiClient: ApiClientProtocol {

    private let baseUrl: String
    private let urlSession: URLSession
    private let interceptor: RequestInterceptorProtocol?

    init(baseUrl: String, interceptor: RequestInterceptorProtocol? = nil) {
        self.baseUrl = baseUrl
        self.urlSession = URLSession.shared
        self.interceptor = interceptor
    }

    func get<ResultType: Decodable>(
        path: String,
        queryParameters: [String: String]?
    ) -> Single<ResultType> {
        executeAndReturn(path: url(with: path), method: .get, parameters: queryParameters)
    }

    func post<ParamsType: Encodable, ResultType: Decodable>(
        path: String,
        body: ParamsType
    ) -> Single<ResultType> {
        executeAndReturn(path: url(with: path), method: .post, parameters: body)
    }

    // swiftlint:disable closure_body_length
    private func executeAndReturn<ParamsType: Encodable, ResultType: Decodable>(
        path: String,
        method: HTTPMethod,
        parameters: ParamsType? = nil
    ) -> Single<ResultType> {
        .create { [weak self] single in
            guard let self = self else { return Disposables.create() }

            let request = self.buildRequest(path: path, method: method, parameters: parameters)
            let dataTask = self.urlSession.dataTask(with: request) { [weak self] data, response, error in
                guard
                    let httpReponse = response as? HTTPURLResponse,
                    let self = self,
                    let statusCode = HttpStatusCode(rawValue: httpReponse.statusCode)
                else {
                    single(.failure(ApiError.badRequest))
                    return
                }
                
                if let error = self.mapToApiError(status: statusCode) {
                    single(.failure(error))
                    return
                }

                do {
                    let result: ResultType = try self.parse(data: data)
                    self.interceptor?.saveHeaders(from: httpReponse)
                    single(.success(result))
                } catch {
                    single(.failure(error))
                }
            }

            dataTask.resume()

            return Disposables.create { dataTask.cancel() }
        }
    }

    private func buildRequest<ParamsType: Encodable>(
        path: String,
        method: HTTPMethod,
        parameters: ParamsType? = nil
    ) -> URLRequest {
        var components = URLComponents(string: "\(path)")!

        if
            method == .get || method == .delete,
            let parameters = parameters as? [String: String]
        {
            components.queryItems = parameters.map(URLQueryItem.init)
        }

        var urlRequest = URLRequest(url: components.url!)
        urlRequest.httpMethod = method.rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

        if
            let parameters = parameters,
            method == .post || method == .patch
        {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        }

        if let interceptor = interceptor {
            interceptor.interceptHeaders.forEach { urlRequest.addValue($0.value, forHTTPHeaderField: $0.key) }
        }

        return urlRequest
    }

    private func parse<ResultType: Decodable>(
        data: Data?,
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase
    ) throws -> ResultType {
        guard let data = data else {
            throw ApiError.noData
        }

        do {
            let dataString = String(decoding: data, as: UTF8.self)
            print("Got data: \(dataString)")
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = keyDecodingStrategy
            return try decoder.decode(ResultType.self, from: data)
        } catch {
            throw ApiError.parseError
        }
    }

    private func mapToApiError(status: HttpStatusCode) -> ApiError? {
        switch status {
        case .ok, .created, .accepted, .noContent:
            return nil
        case .badRequest, .notAcceptable, .unsupportedMediaType, .unprocessableEntity:
            return .badRequest
        case .unauthorized, .forbidden:
            return .unauthorized
        case .notFound:
            return .notFound
        case .methodNotAllowed, .requestTimeout:
            return .general
        case .internalServerError, .notImplemented, .badGateway, .serviceUnavailable, .gatewayTimeout:
            return .serverError
        }
    }

    private func url(with path: String) -> String {
        "\(baseUrl)\(path)"
    }

}

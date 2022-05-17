import Combine
import Foundation

class SimpleApiClient {

    private let urlSession: URLSession
    private let interceptor: RequestInterceptorProtocol?

    init(urlSession: URLSession, interceptor: RequestInterceptorProtocol? = nil) {
        self.urlSession = urlSession
        self.interceptor = interceptor
    }

    func buildUrl<ParamsType: Encodable>(url: String, method: HTTPMethod, parameters: ParamsType?) -> URL? {
        guard var components = URLComponents(string: url) else { return nil }

        var queryItems = components.queryItems ?? []

        if method == .get || method == .delete {
            if let parameters = parameters as? [String: String] {
                queryItems.append(contentsOf: parameters.map(URLQueryItem.init))
                components.queryItems = queryItems
            }
        }

        return components.url
    }

    func buildRequest<ParamsType: Encodable>(
        url: String,
        method: HTTPMethod,
        parameters: ParamsType? = nil
    ) -> URLRequest? {
        guard let url = buildUrl(url: url, method: method, parameters: parameters) else { return nil }

        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = 3 * 60
        urlRequest.httpMethod = method.rawValue

        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        if
            let parameters = parameters,
            method == .post || method == .patch,
            let httpBody = try? encoder.encode(parameters)
        {
            urlRequest.httpBody = httpBody
        }

        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

        if let interceptor = interceptor {
            interceptor.interceptHeaders.forEach { urlRequest.addValue($0.value, forHTTPHeaderField: $0.key) }
        }

        return urlRequest
    }

    func executeAndReturn<ParamsType: Encodable, ResultType: Decodable>(
        url: String,
        method: HTTPMethod,
        parameters: ParamsType? = nil
    ) -> SingleCombine<ResultType, Error> {
        guard let request = buildRequest(url: url, method: method, parameters: parameters) else {
            return .error(error: ApiError.invalidUrl)
        }

        return urlSession
            .dataTaskPublisher(for: request)
            .tryMap { [weak self] result -> ResultType in
                guard
                    let self = self,
                    let response = result.response as? HTTPURLResponse,
                    let statusCode = HttpStatusCode(rawValue: response.statusCode)
                else {
                    throw ApiError.general
                }

                print("RESPONSE: \(statusCode)")

                if let error = self.mapToApiError(status: statusCode) {
                    throw error
                }

                if
                    ResultType.self is Data.Type,
                    let data = result.data as? ResultType
                {
                    return data
                }

                guard let value: ResultType = self.parse(data: result.data) else {
                    throw ApiError.noData
                }

                return value
            }
            .asSingle()
    }

    private func parse<ResultType: Decodable>(
        data: Data?,
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase
    ) -> ResultType? {
        guard let data = data else {
            print("RESPONSE: Data does not exist...")
            return nil
        }

        do {
            let dataString = String(decoding: data, as: UTF8.self)
            print("RESPONSE: \(dataString)")
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = keyDecodingStrategy
            return try decoder.decode(ResultType.self, from: data)
        } catch {
            print("RESPONSE: Unexpected error on decoding data to \(ResultType.self)! (\(error)")
            return nil
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

}

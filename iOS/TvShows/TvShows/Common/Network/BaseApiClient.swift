import Foundation
import RxCocoa
import RxSwift

class BaseApiClient: ApiClientProtocol {

    private let baseUrl: String
    private let urlSession: URLSession

    init(baseUrl: String) {
        self.baseUrl = baseUrl
        self.urlSession = URLSession.shared
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

    private func executeAndReturn<ParamsType: Encodable, ResultType: Decodable>(
        path: String,
        method: HTTPMethod,
        parameters: ParamsType? = nil
    ) -> Single<ResultType> {
        .create { [weak self] single in
            guard let self = self else { return Disposables.create() }

            let request = self.buildRequest(path: path, method: method, parameters: parameters)
            self.urlSession.dataTask(with: request) { [weak self] data, response, error in
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
                
                guard let result: ResultType = self.parse(data: data) else {
                    single(.failure(ApiError.noData))
                    return
                }

                single(.success(result))
            }
            .resume()
            
            return Disposables.create()
        }
    }

    private func execute<ParamsType: Encodable>(
        path: String,
        method: HTTPMethod,
        parameters: ParamsType? = nil
    ) -> Completable {
        .create { [weak self] observer  in
            guard let self = self else { return Disposables.create() }

            let request = self.buildRequest(path: path, method: method, parameters: parameters)
            self.urlSession.dataTask(with: request) { [weak self] _, response, error in
                guard
                    let httpReponse = response as? HTTPURLResponse,
                    let self = self,
                    let statusCode = HttpStatusCode(rawValue: httpReponse.statusCode)
                else {
                    observer(.error(ApiError.badRequest))
                    return
                }

                if let error = self.mapToApiError(status: statusCode) {
                    observer(.error(error))
                    return
                }

                observer(.completed)

            }
            .resume()

            return Disposables.create()
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

        return urlRequest
    }

    private func parse<ResultType: Decodable>(data: Data?) -> ResultType? {
        guard let data = data else {
            print("Data does not exist...")
            return nil
        }

        do {
            let dataString = String(decoding: data, as: UTF8.self)
            print("Got data: \(dataString)")
            return try JSONDecoder().decode(ResultType.self, from: data)
        } catch {
            print("Unexpected error on decoding data to \(ResultType.self)! (\(error)")
            return nil
        }
    }

    private func mapToApiError(status: HttpStatusCode) -> ApiError? {
        switch status {
        case .ok, .created, .accepted, .noContent:
            return nil
        case .badRequest, .notAcceptable, .unsupportedMediaType:
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

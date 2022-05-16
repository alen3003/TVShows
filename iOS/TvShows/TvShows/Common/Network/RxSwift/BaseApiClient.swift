import Foundation
import RxCocoa
import RxSwift

class BaseApiClient: ApiClientProtocol {

    private let baseUrl: String
    private let urlSession: URLSession
    private let userDefaults: UserDefaults = .standard

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
                    self.saveHeaders(from: httpReponse)
                    single(.success(result))
                } catch {
                    single(.failure(error))
                }
            }

            dataTask.resume()

            return Disposables.create { dataTask.cancel() }
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
            let dataTask = self.urlSession.dataTask(with: request) { [weak self] _, response, error in
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

                self.saveHeaders(from: httpReponse)
                observer(.completed)

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

        return urlRequest
    }

    private func parse<ResultType: Decodable>(data: Data?) throws -> ResultType {
        guard let data = data else {
            throw ApiError.noData
        }

        do {
            let dataString = String(decoding: data, as: UTF8.self)
            print("Got data: \(dataString)")
            return try JSONDecoder().decode(ResultType.self, from: data)
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

    // This is just an example and tokens should not be stored via UserDefaults in production
    // For the simplicity we used UserDefaults
    private func saveHeaders(from response: HTTPURLResponse?) {
        if
            let token = response?.allHeaderFields["access-token"],
            let expiry = response?.allHeaderFields["expiry"],
            let client = response?.allHeaderFields["client"],
            let uid = response?.allHeaderFields["uid"]
        {
            userDefaults.set(token, forKey: Constants.UserDefaults.token)
            userDefaults.set(expiry, forKey: Constants.UserDefaults.expiry)
            userDefaults.set(client, forKey: Constants.UserDefaults.client)
            userDefaults.set(uid, forKey: Constants.UserDefaults.uid)
        }
    }

}

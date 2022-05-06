import RxSwift

protocol ApiClientProtocol {

    func get<ResultType: Decodable>(
        path: String,
        queryParameters: [String: String]?
    ) -> Single<ResultType>

    func post<ParamsType: Encodable, ResultType: Decodable>(
        path: String,
        body: ParamsType
    ) -> Single<ResultType>

}

/**
 ApiClientProtocol extension that adds support for default parameters.
 */
extension ApiClientProtocol {

    func get<ResultType: Decodable>(
        path: String,
        queryParameters: [String: String]? = nil
    ) -> Single<ResultType> {
        get(path: path, queryParameters: queryParameters)
    }

}

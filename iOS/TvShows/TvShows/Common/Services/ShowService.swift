class ShowService {

    static let shared = ShowService()

    private let apiClient: ApiClientProtocolCombine
    private let interceptor = AuthInterceptor()

    private init() {
        apiClient = BaseApiClientCombine(baseUrl: Constants.NetworkConstants.base, interceptor: interceptor)
    }

    func fetchShows() -> SingleCombine<ShowWrapper, Error> {
        apiClient.get(path: Constants.NetworkConstants.shows)
    }

    func fetchTopRated() -> SingleCombine<ShowWrapper, Error> {
        apiClient.get(path: Constants.NetworkConstants.topRated)
    }

    func fetchReviews(showId: String) -> SingleCombine<ReviewWrapper, Error> {
        let path = String(format: Constants.NetworkConstants.reviews, showId)
        return apiClient.get(path: path)
    }

}

private extension ShowService {

    func createParameters(showId: String) -> [String : String] {
        var params: [String : String] = [:]
        params["show_id"] = showId
        return params
    }

}

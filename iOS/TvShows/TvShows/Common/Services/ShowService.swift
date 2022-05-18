class ShowService {

    static let shared = ShowService()

    private let apiClient: ApiClientProtocolCombine
    private let interceptor = AuthInterceptor()

    private init() {
        apiClient = BaseApiClientCombine(baseUrl: Constants.NetworkConstants.base, interceptor: interceptor)
    }

    func fetchShows() -> SingleCombine<ShowWrapper, Error> {
        apiClient
            .get(path: Constants.NetworkConstants.shows)
            .subscribeOnBackground()
    }

    func fetchTopRated() -> SingleCombine<ShowWrapper, Error> {
        apiClient
            .get(path: Constants.NetworkConstants.topRated)
            .subscribeOnBackground()
    }

}

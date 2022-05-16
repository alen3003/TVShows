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

}

private extension UserService {
    func createParameters(_ email: String, _ password: String) -> [String : String] {
        var params: [String : String] = [:]
        params["email"] = email
        params["password"] = password
        params["password_confirmation"] = password
        return params
    }
}

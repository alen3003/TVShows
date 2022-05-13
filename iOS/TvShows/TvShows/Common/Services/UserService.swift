import RxSwift

class UserService {

    static let shared = UserService()

    private let apiClient: ApiClientProtocol

    private init() {
        apiClient = BaseApiClient(baseUrl: NetworkConstants.base)
    }

    func login(with email: String, _ password: String) -> Single<MemberWrapper> {
        let params = createParameters(email, password)
        return apiClient.post(path: NetworkConstants.login, body: params)
    }

    func register(with email: String, _ password: String) -> Single<MemberWrapper> {
        let params = createParameters(email, password)
        return apiClient.post(path: NetworkConstants.register, body: params)
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

class ShowService {

    static let shared = ShowService()

    private static let shows = [
        ShowModel(title: "The office", image: "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-12-family-select-2021?wid=940&hei=1112&fmt=jpeg&qlt=90&.v=1617135051000"),
        ShowModel(title: "How I Met Your Mother", image: "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-12-family-select-2021?wid=940&hei=1112&fmt=jpeg&qlt=90&.v=1617135051000"),
        ShowModel(title: "Riverdale", image: "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-12-family-select-2021?wid=940&hei=1112&fmt=jpeg&qlt=90&.v=1617135051000")
    ]

    private let apiClient: ApiClientProtocol

    private init() {
        apiClient = BaseApiClient(baseUrl: NetworkConstants.base)
    }

    func fetchShows() -> SingleCombine<[ShowModel], Error> {
        .just(output: ShowService.shows)
        .subscribeOnBackground()
    }

    static func getShows() -> [ShowModel] {
        shows
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

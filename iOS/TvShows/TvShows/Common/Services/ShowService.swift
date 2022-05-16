class ShowService {

    static let shared = ShowService()

    private static let shows = [
        ShowModel(
            id: "1",
            title: "The Office",
            showDescription: "Description 1",
            image: "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-12-family-select-2021?wid=940&hei=1112&fmt=jpeg&qlt=90&.v=1617135051000",
            averageRating: 1,
            reviewNumber: 2
        ),
        ShowModel(
            id: "2",
            title: "How I Met Your Mother",
            showDescription: "Description 2",
            image: "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-12-family-select-2021?wid=940&hei=1112&fmt=jpeg&qlt=90&.v=1617135051000",
            averageRating: 1,
            reviewNumber: 2
        ),
        ShowModel(
            id: "3",
            title: "Riverdale",
            showDescription: "Description 3",
            image: "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-12-family-select-2021?wid=940&hei=1112&fmt=jpeg&qlt=90&.v=1617135051000",
            averageRating: 1,
            reviewNumber: 2
        )
    ]

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

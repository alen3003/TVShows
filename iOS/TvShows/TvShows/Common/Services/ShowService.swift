class ShowService {

    static let shared = ShowService()

    private let apiClient: ApiClientProtocolCombine
    private let interceptor = AuthInterceptor()

    private init() {
        apiClient = BaseApiClientCombine(baseUrl: Constants.NetworkConstants.base, interceptor: interceptor)
    }

    func fetchShows(paginator: PaginatedResult? = nil) -> SingleCombine<ShowWrapper, Error> {
        apiClient
            .get(path: Constants.NetworkConstants.shows, queryParameters: createParameters(paginator: paginator))
            .handleEvents(receiveOutput: { showWrapper in
                paginator?.setShouldFetchNextPage(showWrapper.shows.count == showWrapper.meta?.pagination.items)
                paginator?.increaseCurrentPage()
            })
            .asSingle()
    }

    func fetchTopRated(paginator: PaginatedResult? = nil) -> SingleCombine<ShowWrapper, Error> {
        apiClient
            .get(path: Constants.NetworkConstants.topRated, queryParameters: createParameters(paginator: paginator))
            .handleEvents(receiveOutput: { showWrapper in
                paginator?.setShouldFetchNextPage(showWrapper.shows.count == showWrapper.meta?.pagination.items)
                paginator?.increaseCurrentPage()
            })
            .asSingle()
    }

    func fetchReviews(showId: String) -> SingleCombine<ReviewWrapper, Error> {
        let path = String(format: Constants.NetworkConstants.reviews, showId)
        return apiClient.get(path: path)
    }

}

private extension ShowService {

    func createParameters(paginator: PaginatedResult?) -> [String : String] {
        guard let paginator = paginator else { return [:] }

        var params: [String : String] = [:]
        params["page"] = "\(paginator.currentPage)"
        params["items"] = "\(paginator.itemsPerPage)"
        return params
    }

}

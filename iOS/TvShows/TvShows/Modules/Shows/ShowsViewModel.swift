import Combine

final class ShowsViewModel: ObservableObject {

    private let showService = ShowService.shared

    @Published private(set) var result: Result<[ShowModel], Error> = .success([])
    private let paginator = PaginatedResult(startingPage: 1, itemsPerPage: 20)

    private let type: ShowsType

    init(type: ShowsType) {
        self.type = type

        fetchShows()
    }

    func fetchMoreShows() {
        guard paginator.shouldFetchNextPage else { return }

        fetchShows()
    }

    private func fetchShows() {
        let showWrapper: SingleCombine<ShowWrapper, Error>
        switch type {
        case .shows:
            showWrapper = showService.fetchShows(paginator: paginator)
        case .topRated:
            showWrapper = showService.fetchTopRated(paginator: paginator)
        }

        showWrapper
            .receiveOnMain()
            .map(\.shows)
            .compactMap { [unowned self] models in
                try? result.get() + models
            }
            .asResult()
            .assign(to: &$result)
    }

}

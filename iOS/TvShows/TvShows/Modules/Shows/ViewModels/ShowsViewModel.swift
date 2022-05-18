import Combine

class ShowsViewModel: ObservableObject {

    private let showService = ShowService.shared

    @Published private(set) var result: Result<[ShowModel], Error> = .success([])

    init() {
        fetchShows()
    }

    func fetchShows() {
        showService
            .fetchShows()
            .receiveOnMain()
            .map(\.shows)
            .asResult()
            .assign(to: &$result)
    }

}

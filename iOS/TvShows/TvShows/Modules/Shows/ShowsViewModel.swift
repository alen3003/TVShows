import Combine

class ShowsViewModel: ObservableObject {

    private let showService = ShowService.shared

    @Published private(set) var result: Result<[ShowModel], Error> = .success([])
    @Published private(set) var type: ShowsType

    init(type: ShowsType) {
        self.type = type

        switch type {
        case .shows:
            fetchShows()
        case .topRated:
            fetchTopRated()
        }
    }

    private func fetchShows() {
        showService
            .fetchShows()
            .receiveOnMain()
            .map(\.shows)
            .asResult()
            .assign(to: &$result)
    }

    private func fetchTopRated() {
        showService
            .fetchTopRated()
            .receiveOnMain()
            .map(\.shows)
            .asResult()
            .assign(to: &$result)
    }

}

import Combine

class ShowsViewModel: ObservableObject {

    private let showService = ShowService.shared

    @Published private(set) var result: Result<[ShowModel], Error> = .success([])

    init(type: ShowsType) {
        fetchShows(for: type)
    }

    private func fetchShows(for type: ShowsType) {
        let shows: SingleCombine<ShowWrapper, Error>
        switch type {
        case .shows:
            shows = showService.fetchShows()
        case .topRated:
            shows = showService.fetchTopRated()
        }

        shows
            .receiveOnMain()
            .map(\.shows)
            .asResult()
            .assign(to: &$result)
    }

}

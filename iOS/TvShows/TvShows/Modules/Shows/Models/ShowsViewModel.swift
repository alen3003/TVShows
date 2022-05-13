import Combine

class ShowsViewModel: ObservableObject {

    private let showService = ShowService.shared

    private var disposables = Set<AnyCancellable>()

    @Published private(set) var shows: [ShowModel] = []

    func fetchShows() {
        showService
            .fetchShows()
            .receiveOnMain()
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [unowned self] shows in
                    self.shows = shows
                }
            )
            .store(in: &disposables)
    }

}
